require_relative 'toy_robot'

RSpec.describe ToyRobot do

  describe '#exec_command' do
    context 'place' do
      it 'places the robot to the selected position and face direction' do
        response = subject.exec_command('PLACE 2,3,SOUTH')
        expect(response[:position]).to eql([2, 3])
        expect(response[:face]).to eq(2)

        response = subject.exec_command('PLACE 0,4,NORTH')
        expect(response[:position]).to eql([0, 4])
        expect(response[:face]).to eq(0)
      end

      context 'when its an invalid position' do
        it 'returns `Invalid Position` Message' do
          response = subject.exec_command('PLACE 0,7,NORTH')
          expect(response).to eql('Invalid Position!')
        end
      end

      context 'when its an invalid face' do
        it 'returns `Invalid Face` Message' do
          response = subject.exec_command('PLACE 0,4,aaaa')
          expect(response).to eql('Invalid Face!')
        end
      end
    end

    context 'move' do
      it 'moves the robot one tile to the current direction' do
        response = subject.exec_command('PLACE 2,4,SOUTH')
        response = subject.exec_command('MOVE')
        expect(response[:position]).to eql([2, 4])
        expect(response[:face]).to eq(2)

        response = subject.exec_command('MOVE')
        expect(response[:position]).to eql([2, 4])
        expect(response[:face]).to eq(2)
      end
    end

    context 'left' do
      it 'rotates face to the left' do
        response = subject.exec_command('PLACE 0,0,EAST')

        response = subject.exec_command('LEFT')
        expect(response[:face]).to eq(0)

        response = subject.exec_command('LEFT')
        expect(response[:face]).to eq(3)
      end
    end

    context 'right' do
      it 'rotates face to the right' do
        response = subject.exec_command('PLACE 0,0,SOUTH')

        response = subject.exec_command('RIGHT')
        expect(response[:face]).to eq(3)

        response = subject.exec_command('RIGHT')
        expect(response[:face]).to eq(0)
      end
    end

    context 'report' do
      it 'gives information about robot position and face' do
        response = subject.exec_command('report')
        expect(response[:position]).to eql([0, 0])
        expect(response[:face]).to eq(0)
      end
    end

    context 'when is given an invalid command' do
      it 'returns Invalid Command! message' do
        response = subject.exec_command('abc 2,3,SOUTH')
        expect(response).to eql('Invalid Command!')
      end
    end
  end
end


trap_seals_unreachable_tail.x64:	file format elf64-x86-64

Disassembly of section .text:

<redir>:
               	endbr64
               	cmpl	$0x3, %edi
               	jl	<addr>
               	cmpl	$0x4, %edi
               	jl	<addr>
               	cmpl	$0x4, %edi
               	jne	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
               	cmpl	$0x2, %edi
               	jl	<addr>
               	movl	$0x14, %eax
               	jmp	<addr>
               	cmpl	$0x1, %edi
               	je	<addr>
               	ud2
               	ud2

<run_request>:
               	endbr64
               	cmpl	$0x2, %edi
               	jl	<addr>
               	cmpl	$0x2, %edi
               	jne	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
               	ud2
               	ud2

<trap_then_return>:
               	endbr64
               	movq	%rdi, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
               	ud2

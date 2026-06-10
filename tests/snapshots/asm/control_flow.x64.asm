
control_flow.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	movslq	%ecx, %rax
               	incq	%rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	retq

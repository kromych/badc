
control_flow.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	movslq	%ecx, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	retq

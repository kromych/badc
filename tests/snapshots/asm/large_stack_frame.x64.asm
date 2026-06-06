
large_stack_frame.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	movslq	%edi, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x28, %eax
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	retq
               	addb	%al, 0x41(%rdx)

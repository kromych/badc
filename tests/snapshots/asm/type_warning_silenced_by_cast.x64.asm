
type_warning_silenced_by_cast.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x5, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

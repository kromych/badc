
write_stdout.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x4, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rsi
               	xorq	%rbx, %rbx
               	movl	$0x68, %eax
               	movb	%al, (%rsi)
               	movl	$0x1, %edi
               	movl	$0x69, %eax
               	movb	%al, 0x1(%rsi)
               	movl	$0xa, %eax
               	movb	%al, 0x2(%rsi)
               	movl	$0x3, %edx
               	movb	%bl, 0x3(%rsi)
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rbx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)

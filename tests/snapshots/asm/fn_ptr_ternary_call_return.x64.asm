
fn_ptr_ternary_call_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<fa>:
               	movq	%rdi, %rax
               	retq

<ga>:
               	leaq	0x1(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movabsq	$0x123456789, %r12      # imm = 0x123456789
               	leaq	-<rip>, %rax       # <addr>
               	movq	%r12, %rdi
               	callq	*%rax
               	movq	%rax, %rbx
               	leaq	-<rip>, %rax       # <addr>
               	movabsq	$0x1234567890, %rdi     # imm = 0x1234567890
               	callq	*%rax
               	movq	%rax, %rdx
               	cmpq	%r12, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$0x1234567891, %r11     # imm = 0x1234567891
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rdx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq

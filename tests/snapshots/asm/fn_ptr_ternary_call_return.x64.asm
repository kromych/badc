
fn_ptr_ternary_call_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<fa>:
               	movq	%rdi, %rax
               	retq

<fb>:
               	movq	%rdi, %rax
               	retq

<ga>:
               	leaq	0x1(%rdi), %rax
               	retq

<gb>:
               	leaq	0x2(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movabsq	$0x123456789, %rbx      # imm = 0x123456789
               	leaq	-<rip>, %rcx       # <addr>
               	jmp	<addr>
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rcx, %rax
               	movq	%rbx, %rdi
               	callq	*%rax
               	movq	%rax, %r13
               	leaq	-<rip>, %rcx       # <addr>
               	jmp	<addr>
               	leaq	-<rip>, %rcx       # <addr>
               	movabsq	$0x1234567890, %rdi     # imm = 0x1234567890
               	movq	%rcx, %rax
               	callq	*%rax
               	movq	%rax, %r12
               	cmpq	%rbx, %r13
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%r13, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x1234567891, %r11     # imm = 0x1234567891
               	movq	%r12, %rax
               	cmpq	%r11, %r12
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movq	%r13, %rsi
               	movq	%r12, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)


switch_jumptable_dead_branch_prune.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<classify>:
               	movslq	%edi, %rdi
               	cmpq	$0xa, %rdi
               	jae	<addr>
               	leaq	<rip>, %r11         # <addr>
               	movslq	(%r11,%rdi,4), %r10
               	addq	%r11, %r10
               	jmpq	*%r10
               	subb	%al, (%rax)
               	addb	%al, (%rax)
               	xorb	$0x0, %al
               	addb	%al, (%rax)
               	cmpl	(%rax), %eax
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%cl, (%rcx)
               	addb	%al, (%rax)
               	pushq	%rax
               	addb	%al, (%rax)
               	addb	%dl, (%rdi)
               	addb	%al, (%rax)
               	popq	%rsi
               	addb	%al, (%rax)
               	addb	%ah, (%rbp)
               	addb	%al, (%rax)
               	insb	%dx, %es:(%rdi)
               	addb	%al, (%rax)
               	addb	%bh, 0xa(%rax)
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq
               	movl	$0x15, %eax
               	jmp	<addr>
               	movl	$0x20, %eax
               	jmp	<addr>
               	movl	$0x2b, %eax
               	jmp	<addr>
               	movl	$0x36, %eax
               	jmp	<addr>
               	movl	$0x41, %eax
               	jmp	<addr>
               	movl	$0x4c, %eax
               	jmp	<addr>
               	movl	$0x57, %eax
               	jmp	<addr>
               	movl	$0x62, %eax
               	jmp	<addr>
               	movl	$0x13, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rdi, %rdi
               	callq	<addr>
               	addq	$0x0, %rax
               	movq	%rax, %rbx
               	shlq	%rbx
               	movl	$0x1, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	movq	%rax, %rbx
               	shlq	%rbx
               	movl	$0x2, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	movq	%rax, %rbx
               	shlq	%rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	movq	%rax, %rbx
               	shlq	%rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	movq	%rax, %rbx
               	shlq	%rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	movq	%rax, %rbx
               	shlq	%rbx
               	movl	$0x6, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	movq	%rax, %rbx
               	shlq	%rbx
               	movl	$0x7, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	movq	%rax, %rbx
               	shlq	%rbx
               	movl	$0x8, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	movq	%rax, %rbx
               	shlq	%rbx
               	movl	$0x9, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	movq	%rax, %rbx
               	shlq	%rbx
               	movl	$0xa, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	movq	%rax, %rbx
               	shlq	%rbx
               	movl	$0xb, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	andq	$0x7f, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)

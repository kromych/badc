
mul_pow2_to_shift.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	shlq	$0x1, %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	movq	%rax, %rdi
               	shlq	$0x4, %rdi
               	movq	%rax, %r8
               	shlq	$0xa, %r8
               	movq	%rax, %r9
               	shlq	$0x1, %r9
               	movl	%r9d, %r9d
               	movq	%rax, %rbx
               	shlq	$0x8, %rbx
               	movl	%ebx, %ebx
               	movq	%rax, %r12
               	shlq	$0x5, %r12
               	shlq	$0x10, %rax
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	%rdi, %rcx
               	addq	%r8, %rcx
               	movslq	%ecx, %rcx
               	movl	%r9d, %edx
               	addq	%rdx, %rcx
               	movl	%ecx, %ecx
               	movl	%ebx, %edx
               	addq	%rdx, %rcx
               	movl	%ecx, %ecx
               	addq	%r12, %rcx
               	leaq	(%rcx,%rax), %rbx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x724c0, %rbx          # imm = 0x724C0
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)

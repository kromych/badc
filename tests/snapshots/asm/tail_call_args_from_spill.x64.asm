
tail_call_args_from_spill.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sink>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movslq	%ecx, %rcx
               	movq	%rsi, %rax
               	shlq	$0x1, %rax
               	addq	%rdi, %rax
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<forward>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%r13, 0x20(%rsp)
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	incq	%rax
               	movq	%rdi, %rcx
               	addq	$0x2, %rcx
               	movq	%rdi, %rsi
               	addq	$0x3, %rsi
               	movq	%rdi, %r8
               	addq	$0x4, %r8
               	movq	%rdi, %r9
               	addq	$0x5, %r9
               	movq	%rdi, %r11
               	addq	$0x6, %r11
               	movq	%rdi, %rbx
               	addq	$0x7, %rbx
               	movq	%rdi, %r12
               	addq	$0x8, %r12
               	movq	%rdi, %r14
               	addq	$0x9, %r14
               	movq	%rdi, %r15
               	addq	$0xa, %r15
               	movq	%rdi, %r10
               	addq	$0xb, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rdi, %r10
               	addq	$0xc, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rdi, %r10
               	addq	$0xd, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rdi, %r10
               	addq	$0xe, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%rdi, %r10
               	addq	$0xf, %r10
               	movq	%r10, 0x38(%rsp)
               	addq	%rdi, %rax
               	addq	%rsi, %rax
               	addq	%r8, %rax
               	addq	%r11, %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r14, %rax
               	addq	%r15, %rax
               	addq	0x58(%rsp), %rax
               	addq	0x50(%rsp), %rax
               	addq	0x40(%rsp), %rax
               	addq	0x38(%rsp), %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movq	%r9, %rax
               	shlq	$0x1, %rax
               	addq	%rcx, %rax
               	leaq	(%r14,%r14,2), %rcx
               	addq	%rcx, %rax
               	movq	0x48(%rsp), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	cmpq	$0xbf, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

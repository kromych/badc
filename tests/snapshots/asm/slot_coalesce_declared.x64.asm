
slot_coalesce_declared.x64:	file format elf64-x86-64

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

<build>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	$0xa, (%rax)
               	movq	$0xb, 0x8(%rax)
               	movq	$0xc, 0x10(%rax)
               	movq	$0xd, 0x18(%rax)
               	movq	$0xe, 0x20(%rax)
               	movq	$0xf, 0x28(%rax)
               	movq	$0x10, 0x30(%rax)
               	movq	$0xa, 0x38(%rax)
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	(%rax,%rax,2), %rdx
               	leaq	0x7(%rdx), %rsi
               	addq	%rsi, %rcx
               	leaq	(%rax,%rax), %rsi
               	addq	%rax, %rsi
               	subq	%rdx, %rsi
               	leaq	(%rcx,%rsi), %rdx
               	leaq	(%rax,%rax,8), %rcx
               	movq	%rcx, %rsi
               	subq	%rcx, %rsi
               	leaq	(%rdx,%rsi), %rcx
               	incq	%rax
               	cmpl	$0x32, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rax,%rax,2), %rsi
               	addq	$0x7, %rsi
               	addq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x32, %eax
               	jl	<addr>
               	cmpq	%rdx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	movq	$0x1234abcd, -0x48(%rbp) # imm = 0x1234ABCD
               	leaq	-0x48(%rbp), %rcx
               	movq	(%rcx), %rdx
               	xorq	$0xfeed, %rdx           # imm = 0xFEED
               	movq	%rdx, (%rcx)
               	xorl	%ebx, %ebx
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x12345520, %rax       # imm = 0x12345520
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	movq	0x18(%rax), %rdi
               	movq	0x20(%rax), %r8
               	movq	0x28(%rax), %r9
               	movq	0x30(%rax), %r12
               	movq	0x38(%rax), %r13
               	xorl	%eax, %eax
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	(%rcx,%rdx), %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	cmpq	$0x65, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>


short_types.x64:	file format elf64-x86-64

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

<rt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x4d2, %edi            # imm = 0x4D2
               	callq	<addr>
               	movq	%rax, %rbx
               	movabsq	$-0x2a, %rdi
               	callq	<addr>
               	movswq	%bx, %rcx
               	cmpl	$0x4d2, %ecx            # imm = 0x4D2
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movswq	%ax, %rdx
               	cmpl	$-0x2a, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	(%rdx,%rdx,2), %rax
               	movslq	%eax, %rax
               	movswq	%ax, %rax
               	cmpl	$-0x7e, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x92492493, %edx       # imm = 0x92492493
               	imulq	%rcx, %rdx
               	movq	%rdx, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	leaq	(%rax,%rsi), %rdi
               	movswq	%di, %r8
               	cmpl	$0xb0, %r8d
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	imulq	$0x7, %rdi, %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movswq	%ax, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	movswq	%dx, %rsi
               	movq	%rsi, %rax
               	shlq	$0xe, %rax
               	movslq	%eax, %rax
               	movswq	%ax, %rax
               	cmpl	$0x4000, %eax           # imm = 0x4000
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movq	%rsi, %rax
               	shlq	$0x10, %rax
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movslq	%ecx, %rax
               	movq	%rax, %rdi
               	andq	$0x8000, %rdi           # imm = 0x8000
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	-0x10000(%rcx), %rax
               	movslq	%eax, %rax
               	movswq	%ax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movq	%rsi, %rax
               	shlq	$0xf, %rax
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movslq	%ecx, %rax
               	movq	%rax, %rdx
               	andq	$0x8000, %rdx           # imm = 0x8000
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	-0x10000(%rcx), %rax
               	movslq	%eax, %rax
               	movswq	%ax, %rax
               	cmpl	$0xffff8000, %eax       # imm = 0xFFFF8000
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$-0x8, %rdi
               	callq	<addr>
               	movswq	%ax, %rax
               	sarq	%rax
               	movswq	%ax, %rax
               	cmpl	$-0x4, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0xfffe, %edi           # imm = 0xFFFE
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%r12, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rbx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	leaq	(%rcx,%rdx), %rax
               	movq	%rax, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	xorq	$0xffff, %rsi           # imm = 0xFFFF
               	movl	%esi, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	incq	%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$-0x1, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rcx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movswq	%r12w, %rsi
               	leaq	(%rdx,%rsi), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movq	%rsi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	%eax, %eax
               	cmpl	%edx, %eax
               	ja	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movq	%rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0xf, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x8000, %rax           # imm = 0x8000
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x8000, %edi           # imm = 0x8000
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movslq	%eax, %rax
               	sarq	%rax
               	cmpl	$0x4000, %eax           # imm = 0x4000
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x64, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0xc8, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movabsq	$-0x12c, %rdi           # imm = 0xFED4
               	callq	<addr>
               	movswq	%ax, %rdx
               	movswq	%bx, %rcx
               	movswq	%r12w, %rsi
               	addq	%rsi, %rcx
               	leaq	(%rcx,%rdx), %rax
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movslq	%ecx, %rax
               	movq	%rax, %rdx
               	andq	$0x8000, %rdx           # imm = 0x8000
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	-0x10000(%rcx), %rax
               	movslq	%eax, %rax
               	movswq	%ax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movabsq	$-0x7, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0xc0de, %edi           # imm = 0xC0DE
               	callq	<addr>
               	movq	%rax, %rcx
               	movswq	%bx, %rax
               	movswq	%r12w, %rdx
               	addq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0xc0de, %rax           # imm = 0xC0DE
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>


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
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x4d2, %edi            # imm = 0x4D2
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	$-0x2a, %rdi
               	callq	<addr>
               	movswq	%bx, %rcx
               	cmpl	$0x4d2, %ecx            # imm = 0x4D2
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movswq	%ax, %rdx
               	cmpl	$-0x2a, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	(%rdx,%rdx,2), %rax
               	movswq	%ax, %rax
               	cmpl	$-0x7e, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rcx, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	imulq	$0x7, %rax, %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movswq	%cx, %rdx
               	movq	%rdx, %rax
               	shlq	$0xe, %rax
               	movswq	%ax, %rax
               	cmpl	$0x4000, %eax           # imm = 0x4000
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rdx, %rax
               	shlq	$0x10, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rsi
               	andq	$0x8000, %rsi           # imm = 0x8000
               	testq	%rsi, %rsi
               	je	<addr>
               	subq	$0x10000, %rax          # imm = 0x10000
               	movswq	%ax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rdx, %rax
               	shlq	$0xf, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	andq	$0x8000, %rcx           # imm = 0x8000
               	testq	%rcx, %rcx
               	je	<addr>
               	subq	$0x10000, %rax          # imm = 0x10000
               	movswq	%ax, %rax
               	cmpl	$0xffff8000, %eax       # imm = 0xFFFF8000
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	$-0x8, %rdi
               	callq	<addr>
               	movswq	%ax, %rax
               	sarq	%rax
               	cmpl	$-0x4, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0xfffe, %edi           # imm = 0xFFFE
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%r12, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rbx, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	leaq	(%rdx,%rsi), %rax
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	xorq	$0xffff, %rcx           # imm = 0xFFFF
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	incq	%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	$-0x1, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rcx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movswq	%r12w, %rsi
               	leaq	(%rdx,%rsi), %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rsi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	cmpl	%edx, %eax
               	ja	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0xf, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x8000, %rax           # imm = 0x8000
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x8000, %edi           # imm = 0x8000
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movslq	%eax, %rax
               	sarq	%rax
               	cmpl	$0x4000, %eax           # imm = 0x4000
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x64, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0xc8, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	$-0x12c, %rdi           # imm = 0xFED4
               	callq	<addr>
               	movswq	%ax, %rdx
               	movswq	%bx, %rcx
               	movswq	%r12w, %rsi
               	addq	%rsi, %rcx
               	leaq	(%rcx,%rdx), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	andq	$0x8000, %rcx           # imm = 0x8000
               	testq	%rcx, %rcx
               	je	<addr>
               	subq	$0x10000, %rax          # imm = 0x10000
               	movswq	%ax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	$-0x7, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0xc0de, %edi           # imm = 0xC0DE
               	callq	<addr>
               	movq	%rax, %rcx
               	movswq	%bx, %rax
               	movswq	%r12w, %rdx
               	addq	%rdx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0xc0de, %rax           # imm = 0xC0DE
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

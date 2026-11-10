
sse_sse2_ssse3_m64_forms_follow_the_sdm.x64:	file format elf64-x86-64

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

<_mm_cvtps_pi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movups	%xmm0, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x20(%rbp), %esi
               	movl	-0x1c(%rbp), %ecx
               	movl	-0x18(%rbp), %edx
               	movl	-0x14(%rbp), %edi
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %esi
               	jle	<addr>
               	movw	%ax, -0x8(%rbp)
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movq	%rax, %rcx
               	movw	%cx, -0x6(%rbp)
               	cmpl	%eax, %edx
               	jle	<addr>
               	movq	%rax, %rdx
               	movw	%dx, -0x4(%rbp)
               	cmpl	%eax, %edi
               	jle	<addr>
               	movw	%ax, -0x2(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	leave
               	retq
               	cmpl	$0xffff8000, %edi       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rdi, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %edx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rdx          # imm = 0x8000
               	jmp	<addr>
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rcx          # imm = 0x8000
               	jmp	<addr>
               	cmpl	$0xffff8000, %esi       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rsi, %rax
               	jmp	<addr>

<_mm_avg_pu8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	%xmm1, -0x8(%rbp)
               	movzbq	-0x10(%rbp), %rax
               	movzbq	-0xf(%rbp), %rcx
               	movzbq	-0xe(%rbp), %rdx
               	movzbq	-0xd(%rbp), %rsi
               	movzbq	-0xc(%rbp), %rdi
               	movzbq	-0xb(%rbp), %r8
               	movzbq	-0xa(%rbp), %r9
               	movzbq	-0x9(%rbp), %rbx
               	movzbq	-0x8(%rbp), %r12
               	movzbq	-0x7(%rbp), %r13
               	movzbq	-0x6(%rbp), %r14
               	movzbq	-0x5(%rbp), %r15
               	movzbq	-0x4(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movzbq	-0x3(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movzbq	-0x2(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movzbq	-0x1(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	addq	%r12, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x8(%rbp)
               	leaq	(%rcx,%r13), %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x7(%rbp)
               	leaq	(%rdx,%r14), %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x6(%rbp)
               	leaq	(%rsi,%r15), %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x5(%rbp)
               	movq	%rdi, %rax
               	addq	0x58(%rsp), %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x4(%rbp)
               	movq	%r8, %rax
               	addq	0x50(%rsp), %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x3(%rbp)
               	movq	%r9, %rax
               	addq	0x48(%rsp), %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x2(%rbp)
               	movq	%rbx, %rax
               	addq	0x40(%rsp), %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x1(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<rnd>:
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %rax # imm = 0x2545F4914F6CDD1D
               	imulq	%rcx, %rax
               	movq	%rcx, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	imulq	%rcx, %rsi
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rsi, %r8
               	testb	$0x3, %r8b
               	jne	<addr>
               	movl	$0xff, %r8d
               	shlxq	%rdx, %r8, %r8
               	xorq	$-0x1, %r8
               	andq	%r8, %rax
               	leaq	0x2(%rdx), %r8
               	shrxq	%r8, %rsi, %r8
               	andq	$0x3, %r8
               	movzbq	(%rdi,%r8), %r8
               	shlxq	%rdx, %r8, %rdx
               	orq	%rdx, %rax
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	retq

<ref_shuffle_pi16>:
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	andq	$0x3, %rax
               	shlq	$0x4, %rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rsi, %rcx
               	sarq	$0x2, %rcx
               	andq	$0x3, %rcx
               	shlq	$0x4, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	movq	%rsi, %rcx
               	sarq	$0x4, %rcx
               	andq	$0x3, %rcx
               	shlq	$0x4, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	sarq	$0x6, %rsi
               	andq	$0x3, %rsi
               	shlq	$0x4, %rsi
               	movslq	%esi, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rax
               	retq

<ref_alignr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%r8d, %r8d
               	movq	%r8, %rax
               	movq	%r8, %r9
               	leaq	(%rdx,%rax), %rcx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	subq	$0x8, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%r8, %rcx
               	movq	%rax, %rbx
               	shlq	$0x3, %rbx
               	movslq	%ebx, %rbx
               	shlxq	%rbx, %rcx, %rcx
               	orq	%rcx, %r9
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%r9, %rax
               	popq	%rbx
               	leave
               	retq

<sse_lanes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x88, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r14d, %r14d
               	callq	<addr>
               	movq	%rax, %rbx
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rbx, -0x70(%rbp)
               	movq	%r12, -0x68(%rbp)
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movq	%r12, %rcx
               	andq	$0xff, %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	shrq	%rax
               	movq	%rbx, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %rdx
               	shrq	$0x8, %rdx
               	andq	$0xff, %rdx
               	addq	%rdx, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x8, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x10, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xff, %rdx
               	addq	%rdx, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %rdx
               	shrq	$0x18, %rdx
               	andq	$0xff, %rdx
               	addq	%rdx, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x18, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x20, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %rdx
               	shrq	$0x20, %rdx
               	andq	$0xff, %rdx
               	addq	%rdx, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x28, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %rdx
               	shrq	$0x28, %rdx
               	andq	$0xff, %rdx
               	addq	%rdx, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x28, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x30, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %rdx
               	shrq	$0x30, %rdx
               	andq	$0xff, %rdx
               	addq	%rdx, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x38, %rcx
               	movq	%r12, %rdx
               	shrq	$0x38, %rdx
               	addq	%rdx, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x38, %rcx
               	movq	%rax, %r13
               	orq	%rcx, %r13
               	leaq	-0x70(%rbp), %r9
               	leaq	-0x68(%rbp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	movsd	%xmm0, -0x60(%rbp)
               	movq	-0x60(%rbp), %rax
               	cmpq	%r13, %rax
               	jne	<addr>
               	leaq	-0x70(%rbp), %r9
               	leaq	-0x68(%rbp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	movsd	%xmm0, -0x58(%rbp)
               	movq	-0x58(%rbp), %rax
               	cmpq	%r13, %rax
               	jne	<addr>
               	movq	%rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%r12, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	incq	%rax
               	shrq	%rax
               	movq	%rbx, %rcx
               	shrq	$0x10, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%r12, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	addq	%rdx, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x20, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%r12, %rdx
               	shrq	$0x20, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	addq	%rdx, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x30, %rcx
               	movq	%r12, %rdx
               	shrq	$0x30, %rdx
               	addq	%rdx, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rax
               	movzwq	-0x70(%rbp), %rcx
               	movzwq	-0x6e(%rbp), %rdx
               	movzwq	-0x6c(%rbp), %rsi
               	movzwq	-0x6a(%rbp), %rdi
               	movzwq	-0x68(%rbp), %r8
               	movzwq	-0x66(%rbp), %r9
               	movzwq	-0x64(%rbp), %r13
               	movzwq	-0x62(%rbp), %r15
               	addq	%r8, %rcx
               	incq	%rcx
               	shrq	%rcx
               	movw	%cx, -0x50(%rbp)
               	leaq	(%rdx,%r9), %rcx
               	incq	%rcx
               	shrq	%rcx
               	movw	%cx, -0x4e(%rbp)
               	leaq	(%rsi,%r13), %rcx
               	incq	%rcx
               	shrq	%rcx
               	movw	%cx, -0x4c(%rbp)
               	leaq	(%rdi,%r15), %rcx
               	incq	%rcx
               	shrq	%rcx
               	movw	%cx, -0x4a(%rbp)
               	movq	-0x50(%rbp), %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movzwq	-0x70(%rbp), %rcx
               	movzwq	-0x6e(%rbp), %rdx
               	movzwq	-0x6c(%rbp), %rsi
               	movzwq	-0x6a(%rbp), %rdi
               	movzwq	-0x68(%rbp), %r8
               	movzwq	-0x66(%rbp), %r9
               	movzwq	-0x64(%rbp), %r13
               	movzwq	-0x62(%rbp), %r15
               	addq	%r8, %rcx
               	incq	%rcx
               	shrq	%rcx
               	movw	%cx, -0x50(%rbp)
               	leaq	(%rdx,%r9), %rcx
               	incq	%rcx
               	shrq	%rcx
               	movw	%cx, -0x4e(%rbp)
               	leaq	(%rsi,%r13), %rcx
               	incq	%rcx
               	shrq	%rcx
               	movw	%cx, -0x4c(%rbp)
               	leaq	(%rdi,%r15), %rcx
               	incq	%rcx
               	shrq	%rcx
               	movw	%cx, -0x4a(%rbp)
               	movq	-0x50(%rbp), %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movq	%rcx, %rdi
               	movq	%rcx, %rax
               	shlq	$0x4, %rax
               	movslq	%eax, %rdx
               	shrxq	%rdx, %rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %r8
               	shrq	$0xf, %r8
               	testq	%r8, %r8
               	je	<addr>
               	subq	$0x10000, %rax          # imm = 0x10000
               	shrxq	%rdx, %r12, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %r8
               	shrq	$0xf, %r8
               	testq	%r8, %r8
               	je	<addr>
               	subq	$0x10000, %rdx          # imm = 0x10000
               	cmpl	%edx, %eax
               	jle	<addr>
               	movq	%rax, %r8
               	movq	%r8, %r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movq	%rcx, %r8
               	shlq	$0x4, %r8
               	movslq	%r8d, %r13
               	shlxq	%r13, %r9, %r9
               	orq	%r9, %rdi
               	cmpl	%edx, %eax
               	jl	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	%rdx, %r8
               	jmp	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movslq	%r8d, %rdx
               	shlxq	%rdx, %rax, %rax
               	orq	%rax, %rsi
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x48(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x40(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x38(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	leaq	-0x30(%rbp), %r8
               	movswq	(%r8,%rax,2), %r8
               	cmpl	%r8d, %ecx
               	jle	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	movw	%cx, (%rdx,%rax,2)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x48(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x40(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x38(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	leaq	-0x30(%rbp), %r8
               	movswq	(%r8,%rax,2), %r8
               	cmpl	%r8d, %ecx
               	jle	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	movw	%cx, (%rdx,%rax,2)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorl	%eax, %eax
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x38(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	leaq	-0x30(%rbp), %rdi
               	movswq	(%rdi,%rax,2), %rdi
               	cmpl	%edi, %ecx
               	jge	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	movw	%cx, (%rdx,%rax,2)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorl	%eax, %eax
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x38(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	leaq	-0x30(%rbp), %rdi
               	movswq	(%rdi,%rax,2), %rdi
               	cmpl	%edi, %ecx
               	jge	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	movw	%cx, (%rdx,%rax,2)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	movq	%rax, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %rdx
               	shrxq	%rdx, %rbx, %rcx
               	andq	$0xff, %rcx
               	shrxq	%rdx, %r12, %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %ecx
               	jbe	<addr>
               	movq	%rcx, %r9
               	movslq	%r8d, %r8
               	shlxq	%r8, %r9, %r8
               	orq	%r8, %rdi
               	cmpl	%edx, %ecx
               	jb	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rdx, %r9
               	movslq	%r8d, %r8
               	shlxq	%r8, %r9, %r8
               	orq	%r8, %rdi
               	cmpl	%edx, %ecx
               	jae	<addr>
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	orq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x48(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x40(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x38(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	leaq	-0x30(%rbp), %r8
               	movzbq	(%r8,%rax), %r8
               	cmpl	%r8d, %ecx
               	jle	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x48(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x40(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x38(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	leaq	-0x30(%rbp), %r8
               	movzbq	(%r8,%rax), %r8
               	cmpl	%r8d, %ecx
               	jle	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorl	%eax, %eax
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x38(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	leaq	-0x30(%rbp), %rdi
               	movzbq	(%rdi,%rax), %rdi
               	cmpl	%edi, %ecx
               	jge	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorl	%eax, %eax
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x38(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	leaq	-0x30(%rbp), %rdi
               	movzbq	(%rdi,%rax), %rdi
               	cmpl	%edi, %ecx
               	jge	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	shrq	$0x7, %rax
               	movq	%rbx, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xff, %rcx
               	shrq	$0x7, %rcx
               	shlq	%rcx
               	orq	%rax, %rcx
               	movq	%rbx, %rax
               	shrq	$0x10, %rax
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	shrq	$0x7, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rbx, %rdx
               	shrq	$0x18, %rdx
               	andq	$0xff, %rdx
               	shrq	$0x7, %rdx
               	shlq	$0x3, %rdx
               	orq	%rcx, %rdx
               	movq	%rbx, %rcx
               	shrq	$0x20, %rcx
               	movq	%rcx, %rsi
               	andq	$0xff, %rsi
               	shrq	$0x7, %rsi
               	shlq	$0x4, %rsi
               	orq	%rsi, %rdx
               	movq	%rbx, %rsi
               	shrq	$0x28, %rsi
               	andq	$0xff, %rsi
               	shrq	$0x7, %rsi
               	shlq	$0x5, %rsi
               	orq	%rsi, %rdx
               	movq	%rbx, %rsi
               	shrq	$0x30, %rsi
               	andq	$0xff, %rsi
               	shrq	$0x7, %rsi
               	shlq	$0x6, %rsi
               	orq	%rsi, %rdx
               	movq	%rbx, %rsi
               	shrq	$0x38, %rsi
               	shrq	$0x7, %rsi
               	shlq	$0x7, %rsi
               	orq	%rsi, %rdx
               	leaq	-0x70(%rbp), %rsi
               	leaq	-0x40(%rbp), %rdi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdi)
               	movzbq	-0x40(%rbp), %rsi
               	shrq	$0x7, %rsi
               	movzbq	-0x3f(%rbp), %rdi
               	shrq	$0x7, %rdi
               	shlq	%rdi
               	orq	%rdi, %rsi
               	movzbq	-0x3e(%rbp), %rdi
               	shrq	$0x7, %rdi
               	shlq	$0x2, %rdi
               	orq	%rdi, %rsi
               	movzbq	-0x3d(%rbp), %rdi
               	shrq	$0x7, %rdi
               	shlq	$0x3, %rdi
               	orq	%rdi, %rsi
               	movzbq	-0x3c(%rbp), %rdi
               	shrq	$0x7, %rdi
               	shlq	$0x4, %rdi
               	orq	%rdi, %rsi
               	movzbq	-0x3b(%rbp), %rdi
               	shrq	$0x7, %rdi
               	shlq	$0x5, %rdi
               	orq	%rdi, %rsi
               	movzbq	-0x3a(%rbp), %rdi
               	shrq	$0x7, %rdi
               	shlq	$0x6, %rdi
               	orq	%rdi, %rsi
               	movzbq	-0x39(%rbp), %rdi
               	shrq	$0x7, %rdi
               	shlq	$0x7, %rdi
               	orq	%rdi, %rsi
               	cmpl	%edx, %esi
               	jne	<addr>
               	leaq	-0x70(%rbp), %rsi
               	leaq	-0x40(%rbp), %rdi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdi)
               	movzbq	-0x40(%rbp), %rsi
               	shrq	$0x7, %rsi
               	movzbq	-0x3f(%rbp), %rdi
               	shrq	$0x7, %rdi
               	shlq	%rdi
               	orq	%rdi, %rsi
               	movzbq	-0x3e(%rbp), %rdi
               	shrq	$0x7, %rdi
               	shlq	$0x2, %rdi
               	orq	%rdi, %rsi
               	movzbq	-0x3d(%rbp), %rdi
               	shrq	$0x7, %rdi
               	shlq	$0x3, %rdi
               	orq	%rdi, %rsi
               	movzbq	-0x3c(%rbp), %rdi
               	shrq	$0x7, %rdi
               	shlq	$0x4, %rdi
               	orq	%rdi, %rsi
               	movzbq	-0x3b(%rbp), %rdi
               	shrq	$0x7, %rdi
               	shlq	$0x5, %rdi
               	orq	%rdi, %rsi
               	movzbq	-0x3a(%rbp), %rdi
               	shrq	$0x7, %rdi
               	shlq	$0x6, %rdi
               	orq	%rdi, %rsi
               	movzbq	-0x39(%rbp), %rdi
               	shrq	$0x7, %rdi
               	shlq	$0x7, %rdi
               	orq	%rdi, %rsi
               	cmpl	%edx, %esi
               	jne	<addr>
               	movq	%rbx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%r12, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	imulq	%rsi, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%r12, %rsi
               	shrq	$0x10, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	imulq	%rsi, %rax
               	shrq	$0x10, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0x10, %rax
               	orq	%rdx, %rax
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%r12, %rdx
               	shrq	$0x20, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	imulq	%rdx, %rcx
               	shrq	$0x10, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x30, %rcx
               	movq	%r12, %rdx
               	shrq	$0x30, %rdx
               	imulq	%rdx, %rcx
               	shrq	$0x10, %rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rax
               	leaq	-0x70(%rbp), %rdx
               	leaq	-0x68(%rbp), %rsi
               	leaq	-0x48(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x40(%rbp), %rdx
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x38(%rbp), %rsi
               	movq	(%rcx), %r10
               	movq	%r10, (%rsi)
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movzwq	-0x38(%rbp), %rcx
               	movzwq	-0x30(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, %ecx
               	shrq	$0x10, %rcx
               	movw	%cx, -0x28(%rbp)
               	movzwq	-0x36(%rbp), %rcx
               	movzwq	-0x2e(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, %ecx
               	shrq	$0x10, %rcx
               	movw	%cx, -0x26(%rbp)
               	movzwq	-0x34(%rbp), %rcx
               	movzwq	-0x2c(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, %ecx
               	shrq	$0x10, %rcx
               	movw	%cx, -0x24(%rbp)
               	movzwq	-0x32(%rbp), %rcx
               	movzwq	-0x2a(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, %ecx
               	shrq	$0x10, %rcx
               	movw	%cx, -0x22(%rbp)
               	movq	-0x28(%rbp), %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	leaq	-0x70(%rbp), %rdx
               	leaq	-0x68(%rbp), %rsi
               	leaq	-0x48(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x40(%rbp), %rdx
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x38(%rbp), %rsi
               	movq	(%rcx), %r10
               	movq	%r10, (%rsi)
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movzwq	-0x38(%rbp), %rcx
               	movzwq	-0x30(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, %ecx
               	shrq	$0x10, %rcx
               	movw	%cx, -0x28(%rbp)
               	movzwq	-0x36(%rbp), %rcx
               	movzwq	-0x2e(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, %ecx
               	shrq	$0x10, %rcx
               	movw	%cx, -0x26(%rbp)
               	movzwq	-0x34(%rbp), %rcx
               	movzwq	-0x2c(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, %ecx
               	shrq	$0x10, %rcx
               	movw	%cx, -0x24(%rbp)
               	movzwq	-0x32(%rbp), %rcx
               	movzwq	-0x2a(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, %ecx
               	shrq	$0x10, %rcx
               	movw	%cx, -0x22(%rbp)
               	movq	-0x28(%rbp), %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rbx, %rsi
               	andq	$0xff, %rsi
               	shrxq	%rcx, %r12, %rcx
               	movq	%rcx, %rdi
               	andq	$0xff, %rdi
               	movq	%rsi, %rcx
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x38(%rbp), %rsi
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	leaq	-0x38(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	leaq	-0x30(%rbp), %rdi
               	movzbq	(%rdi,%rax), %rdi
               	cmpl	%edi, %ecx
               	jle	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	leaq	-0x30(%rbp), %rdi
               	movzbq	(%rdi,%rax), %rdi
               	subq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	leaq	-0x38(%rbp), %rdi
               	movzbq	(%rdi,%rax), %rdi
               	subq	%rdi, %rcx
               	addq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x38(%rbp), %rsi
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	leaq	-0x38(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	leaq	-0x30(%rbp), %rdi
               	movzbq	(%rdi,%rax), %rdi
               	cmpl	%edi, %ecx
               	jle	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	leaq	-0x30(%rbp), %rdi
               	movzbq	(%rdi,%rax), %rdi
               	subq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	leaq	-0x38(%rbp), %rdi
               	movzbq	(%rdi,%rax), %rdi
               	subq	%rdi, %rcx
               	addq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movswq	-0x40(%rbp), %rax
               	movw	%ax, -0x38(%rbp)
               	movw	%ax, -0x36(%rbp)
               	movswq	-0x40(%rbp), %rax
               	movw	%ax, -0x34(%rbp)
               	movw	%ax, -0x32(%rbp)
               	movq	-0x38(%rbp), %r13
               	xorl	%esi, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movswq	-0x40(%rbp), %rax
               	movw	%ax, -0x38(%rbp)
               	movw	%ax, -0x36(%rbp)
               	movswq	-0x40(%rbp), %rax
               	movw	%ax, -0x34(%rbp)
               	movw	%ax, -0x32(%rbp)
               	movq	-0x38(%rbp), %r13
               	xorl	%esi, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movswq	-0x3a(%rbp), %rax
               	movw	%ax, -0x38(%rbp)
               	movswq	-0x3c(%rbp), %rax
               	movw	%ax, -0x36(%rbp)
               	movswq	-0x3e(%rbp), %rax
               	movw	%ax, -0x34(%rbp)
               	movswq	-0x40(%rbp), %rax
               	movw	%ax, -0x32(%rbp)
               	movq	-0x38(%rbp), %r13
               	movl	$0x1b, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movswq	-0x3a(%rbp), %rax
               	movw	%ax, -0x38(%rbp)
               	movswq	-0x3c(%rbp), %rax
               	movw	%ax, -0x36(%rbp)
               	movswq	-0x3e(%rbp), %rax
               	movw	%ax, -0x34(%rbp)
               	movswq	-0x40(%rbp), %rax
               	movw	%ax, -0x32(%rbp)
               	movq	-0x38(%rbp), %r13
               	movl	$0x1b, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movswq	-0x3c(%rbp), %rax
               	movw	%ax, -0x38(%rbp)
               	movswq	-0x3a(%rbp), %rax
               	movw	%ax, -0x36(%rbp)
               	movswq	-0x40(%rbp), %rax
               	movw	%ax, -0x34(%rbp)
               	movswq	-0x3e(%rbp), %rax
               	movw	%ax, -0x32(%rbp)
               	movq	-0x38(%rbp), %r13
               	movl	$0x4e, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movswq	-0x3c(%rbp), %rax
               	movw	%ax, -0x38(%rbp)
               	movswq	-0x3a(%rbp), %rax
               	movw	%ax, -0x36(%rbp)
               	movswq	-0x40(%rbp), %rax
               	movw	%ax, -0x34(%rbp)
               	movswq	-0x3e(%rbp), %rax
               	movw	%ax, -0x32(%rbp)
               	movq	-0x38(%rbp), %r13
               	movl	$0x4e, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movswq	-0x3a(%rbp), %rax
               	movw	%ax, -0x38(%rbp)
               	movswq	-0x40(%rbp), %rax
               	movw	%ax, -0x36(%rbp)
               	movswq	-0x3e(%rbp), %rax
               	movw	%ax, -0x34(%rbp)
               	movswq	-0x3c(%rbp), %rax
               	movw	%ax, -0x32(%rbp)
               	movq	-0x38(%rbp), %r13
               	movl	$0x93, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movswq	-0x3a(%rbp), %rax
               	movw	%ax, -0x38(%rbp)
               	movswq	-0x40(%rbp), %rax
               	movw	%ax, -0x36(%rbp)
               	movswq	-0x3e(%rbp), %rax
               	movw	%ax, -0x34(%rbp)
               	movswq	-0x3c(%rbp), %rax
               	movw	%ax, -0x32(%rbp)
               	movq	-0x38(%rbp), %r13
               	movl	$0x93, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movswq	-0x40(%rbp), %rax
               	movw	%ax, -0x38(%rbp)
               	movswq	-0x3e(%rbp), %rax
               	movw	%ax, -0x36(%rbp)
               	movswq	-0x3c(%rbp), %rax
               	movw	%ax, -0x34(%rbp)
               	movswq	-0x3a(%rbp), %rax
               	movw	%ax, -0x32(%rbp)
               	movq	-0x38(%rbp), %r13
               	movl	$0xe4, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movswq	-0x40(%rbp), %rax
               	movw	%ax, -0x38(%rbp)
               	movswq	-0x3e(%rbp), %rax
               	movw	%ax, -0x36(%rbp)
               	movswq	-0x3c(%rbp), %rax
               	movw	%ax, -0x34(%rbp)
               	movswq	-0x3a(%rbp), %rax
               	movw	%ax, -0x32(%rbp)
               	movq	-0x38(%rbp), %r13
               	movl	$0xe4, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movswq	-0x3a(%rbp), %rax
               	movw	%ax, -0x38(%rbp)
               	movw	%ax, -0x36(%rbp)
               	movswq	-0x3a(%rbp), %rax
               	movw	%ax, -0x34(%rbp)
               	movw	%ax, -0x32(%rbp)
               	movq	-0x38(%rbp), %r13
               	movl	$0xff, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movswq	-0x3a(%rbp), %rax
               	movw	%ax, -0x38(%rbp)
               	movw	%ax, -0x36(%rbp)
               	movswq	-0x3a(%rbp), %rax
               	movw	%ax, -0x34(%rbp)
               	movw	%ax, -0x32(%rbp)
               	movq	-0x38(%rbp), %r13
               	movl	$0xff, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	movswq	-0x70(%rbp), %rax
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%eax, %edx
               	jne	<addr>
               	movswq	-0x70(%rbp), %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movw	%r12w, -0x40(%rbp)
               	movq	-0x40(%rbp), %rdx
               	movq	%rbx, %rsi
               	andq	$-0x10000, %rsi         # imm = 0xFFFF0000
               	movq	%r12, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	orq	%rcx, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	-0x70(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x40(%rbp), %rsi
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	movw	%r12w, -0x40(%rbp)
               	movq	-0x40(%rbp), %rsi
               	leaq	-0x48(%rbp), %rax
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	movw	%r12w, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movswq	-0x6e(%rbp), %rax
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rbx, %rax
               	shrq	$0x10, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%eax, %edx
               	jne	<addr>
               	movswq	-0x6e(%rbp), %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	-0x70(%rbp), %rdx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	movw	%r12w, -0x3e(%rbp)
               	movq	-0x40(%rbp), %rax
               	movabsq	$-0xffff0001, %rdx      # imm = 0xFFFFFFFF0000FFFF
               	andq	%rbx, %rdx
               	shlq	$0x10, %rcx
               	orq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x48(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x40(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	movw	%r12w, -0x3e(%rbp)
               	movq	-0x40(%rbp), %rdx
               	leaq	-0x48(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x40(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movw	%r12w, -0x3e(%rbp)
               	movq	-0x40(%rbp), %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movswq	-0x6c(%rbp), %rax
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rbx, %rax
               	shrq	$0x20, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%eax, %ecx
               	jne	<addr>
               	movswq	-0x6c(%rbp), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	%eax, %ecx
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	movw	%r12w, -0x3c(%rbp)
               	movq	-0x40(%rbp), %rax
               	movabsq	$-0xffff00000001, %rdx  # imm = 0xFFFF0000FFFFFFFF
               	andq	%rbx, %rdx
               	movq	%r12, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	shlq	$0x20, %rsi
               	orq	%rsi, %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movw	%r12w, -0x3c(%rbp)
               	movq	-0x40(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	movw	%r12w, -0x3c(%rbp)
               	movq	-0x40(%rbp), %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	movswq	-0x6a(%rbp), %rax
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rbx, %rax
               	shrq	$0x30, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	movswq	-0x6a(%rbp), %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movw	%r12w, -0x3a(%rbp)
               	movq	-0x40(%rbp), %rcx
               	movabsq	$0xffffffffffff, %rdx   # imm = 0xFFFFFFFFFFFF
               	andq	%rbx, %rdx
               	movq	%r12, %rsi
               	shlq	$0x30, %rsi
               	orq	%rsi, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	leaq	-0x70(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	movw	%r12w, -0x3a(%rbp)
               	movq	-0x40(%rbp), %rdx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movw	%r12w, -0x3a(%rbp)
               	movq	-0x40(%rbp), %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movb	$-0x60, -0x10(%rbp)
               	movb	$-0x60, -0x20(%rbp)
               	movb	$-0x5f, -0xf(%rbp)
               	movb	$-0x5f, -0x1f(%rbp)
               	movb	$-0x5e, -0xe(%rbp)
               	movb	$-0x5e, -0x1e(%rbp)
               	movb	$-0x5d, -0xd(%rbp)
               	movb	$-0x5d, -0x1d(%rbp)
               	movb	$-0x5c, -0xc(%rbp)
               	movb	$-0x5c, -0x1c(%rbp)
               	movb	$-0x5b, -0xb(%rbp)
               	movb	$-0x5b, -0x1b(%rbp)
               	movb	$-0x5a, -0xa(%rbp)
               	movb	$-0x5a, -0x1a(%rbp)
               	movb	$-0x59, -0x9(%rbp)
               	movb	$-0x59, -0x19(%rbp)
               	movb	$-0x58, -0x8(%rbp)
               	movb	$-0x58, -0x18(%rbp)
               	movb	$-0x57, -0x7(%rbp)
               	movb	$-0x57, -0x17(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %r12, %rdx
               	andq	$0xff, %rdx
               	testb	$-0x80, %dl
               	je	<addr>
               	leaq	-0x10(%rbp), %rdx
               	leaq	0x1(%rax), %rsi
               	shrxq	%rcx, %rbx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rdx
               	leaq	-0x68(%rbp), %rsi
               	leaq	-0x20(%rbp), %rcx
               	leaq	0x1(%rcx), %rdi
               	leaq	-0x48(%rbp), %rax
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %r8
               	movq	(%rsi), %r10
               	movq	%r10, (%r8)
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x30(%rbp), %rsi
               	movq	(%r8), %r10
               	movq	%r10, (%rsi)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %r8
               	testb	$-0x80, %r8b
               	je	<addr>
               	movsbq	(%rdx,%rax), %r8
               	movb	%r8b, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	leaq	-0x10(%rbp), %rsi
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	leaq	-0x20(%rbp), %rax
               	leaq	0x1(%rax), %rsi
               	leaq	-0x48(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rdi
               	movq	(%rdx), %r10
               	movq	%r10, (%rdi)
               	leaq	-0x38(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x30(%rbp), %rdx
               	movq	(%rdi), %r10
               	movq	%r10, (%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	testb	$-0x80, %dil
               	je	<addr>
               	movsbq	(%rcx,%rax), %rdi
               	movb	%dil, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	incq	%r14
               	cmpl	$0x7d0, %r14d           # imm = 0x7D0
               	jl	<addr>
               	leaq	-0x8(%rbp), %rax
               	movabsq	$0x123456789abcdef, %rcx # imm = 0x123456789ABCDEF
               	movntiq	%rcx, (%rax)
               	sfence
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x98, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x92, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x89, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x89, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x88, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x88, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x87, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x87, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x86, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x86, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x7f, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x7e, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x7d, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x7c, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x7b, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x7a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x77, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x71, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x6d, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x69, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x68, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x61, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x60, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x59, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x55, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<sse_conversions>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movl	$0x40200000, -0x18(%rbp) # imm = 0x40200000
               	movl	$0xc0600000, -0x14(%rbp) # imm = 0xC0600000
               	movl	$0x501502f9, -0x10(%rbp) # imm = 0x501502F9
               	movl	$0x7fc00000, -0xc(%rbp) # imm = 0x7FC00000
               	leaq	-0x90(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, -0x90(%rbp)
               	movss	-0x14(%rbp), %xmm0
               	movss	%xmm0, -0x8c(%rbp)
               	movss	-0x10(%rbp), %xmm0
               	movss	%xmm0, -0x88(%rbp)
               	movss	-0xc(%rbp), %xmm0
               	movss	%xmm0, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	-0xb0(%rbp), %ecx
               	movl	%ecx, -0xd0(%rbp)
               	movl	-0xac(%rbp), %ecx
               	movl	%ecx, -0xcc(%rbp)
               	movl	-0xa0(%rbp), %ecx
               	movl	%ecx, -0xc8(%rbp)
               	movl	-0x9c(%rbp), %ecx
               	movl	%ecx, -0xc4(%rbp)
               	leaq	-0xc0(%rbp), %rcx
               	movups	-0xd0(%rbp), %xmm1
               	movups	%xmm1, -0xc0(%rbp)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	cvtps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x80(%rbp), %ecx
               	movl	-0x7c(%rbp), %edx
               	leaq	-0x38(%rbp), %rsi
               	movq	$0x0, (%rsi)
               	movl	%ecx, -0x38(%rbp)
               	movl	%edx, -0x34(%rbp)
               	movq	-0x38(%rbp), %rcx
               	movabsq	$-0x3fffffffe, %r11     # imm = 0xFFFFFFFC00000002
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xb0, %eax
               	leave
               	retq
               	movups	%xmm0, -0xb0(%rbp)
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	-0xb0(%rbp), %ecx
               	movl	%ecx, -0xd0(%rbp)
               	movl	-0xac(%rbp), %ecx
               	movl	%ecx, -0xcc(%rbp)
               	movl	-0xa0(%rbp), %ecx
               	movl	%ecx, -0xc8(%rbp)
               	movl	-0x9c(%rbp), %ecx
               	movl	%ecx, -0xc4(%rbp)
               	leaq	-0xc0(%rbp), %rcx
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	cvtps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x80(%rbp), %ecx
               	movl	-0x7c(%rbp), %edx
               	leaq	-0x38(%rbp), %rsi
               	movq	$0x0, (%rsi)
               	movl	%ecx, -0x38(%rbp)
               	movl	%edx, -0x34(%rbp)
               	movq	-0x38(%rbp), %rcx
               	movabsq	$-0x3fffffffe, %r11     # imm = 0xFFFFFFFC00000002
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xb1, %eax
               	leave
               	retq
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movl	$0x501502f9, -0x18(%rbp) # imm = 0x501502F9
               	movl	$0x7fc00000, -0x14(%rbp) # imm = 0x7FC00000
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	leaq	-0x90(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, -0x90(%rbp)
               	movss	-0x14(%rbp), %xmm0
               	movss	%xmm0, -0x8c(%rbp)
               	movss	-0x10(%rbp), %xmm0
               	movss	%xmm0, -0x88(%rbp)
               	movss	-0xc(%rbp), %xmm0
               	movss	%xmm0, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	-0xb0(%rbp), %eax
               	movl	%eax, -0xd0(%rbp)
               	movl	-0xac(%rbp), %eax
               	movl	%eax, -0xcc(%rbp)
               	movl	-0xa0(%rbp), %eax
               	movl	%eax, -0xc8(%rbp)
               	movl	-0x9c(%rbp), %eax
               	movl	%eax, -0xc4(%rbp)
               	leaq	-0xc0(%rbp), %rax
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	leaq	-0x80(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x80(%rbp), %eax
               	movl	-0x7c(%rbp), %ecx
               	leaq	-0x38(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movl	%eax, -0x38(%rbp)
               	movl	%ecx, -0x34(%rbp)
               	movq	-0x38(%rbp), %rax
               	movabsq	$-0x7fffffff80000000, %r11 # imm = 0x8000000080000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb2, %eax
               	leave
               	retq
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movl	$0xc02ccccd, -0x18(%rbp) # imm = 0xC02CCCCD
               	movl	$0x402ccccd, -0x14(%rbp) # imm = 0x402CCCCD
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	leaq	-0x90(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, -0x90(%rbp)
               	movss	-0x14(%rbp), %xmm0
               	movss	%xmm0, -0x8c(%rbp)
               	movss	-0x10(%rbp), %xmm0
               	movss	%xmm0, -0x88(%rbp)
               	movss	-0xc(%rbp), %xmm0
               	movss	%xmm0, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	-0xb0(%rbp), %eax
               	movl	%eax, -0xd0(%rbp)
               	movl	-0xac(%rbp), %eax
               	movl	%eax, -0xcc(%rbp)
               	movl	-0xa0(%rbp), %eax
               	movl	%eax, -0xc8(%rbp)
               	movl	-0x9c(%rbp), %eax
               	movl	%eax, -0xc4(%rbp)
               	leaq	-0xc0(%rbp), %rax
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	leaq	-0x70(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvttps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x70(%rbp), %eax
               	movl	-0x6c(%rbp), %ecx
               	leaq	-0x20(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movl	%eax, -0x20(%rbp)
               	movl	%ecx, -0x1c(%rbp)
               	movq	-0x20(%rbp), %rax
               	movabsq	$0x2fffffffe, %r11      # imm = 0x2FFFFFFFE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb3, %eax
               	leave
               	retq
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movl	$0xcf000000, -0x18(%rbp) # imm = 0xCF000000
               	movl	$0x4f000000, -0x14(%rbp) # imm = 0x4F000000
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	leaq	-0x90(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, -0x90(%rbp)
               	movss	-0x14(%rbp), %xmm0
               	movss	%xmm0, -0x8c(%rbp)
               	movss	-0x10(%rbp), %xmm0
               	movss	%xmm0, -0x88(%rbp)
               	movss	-0xc(%rbp), %xmm0
               	movss	%xmm0, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	-0xb0(%rbp), %eax
               	movl	%eax, -0xd0(%rbp)
               	movl	-0xac(%rbp), %eax
               	movl	%eax, -0xcc(%rbp)
               	movl	-0xa0(%rbp), %eax
               	movl	%eax, -0xc8(%rbp)
               	movl	-0x9c(%rbp), %eax
               	movl	%eax, -0xc4(%rbp)
               	leaq	-0xc0(%rbp), %rax
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	leaq	-0x70(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvttps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x70(%rbp), %eax
               	movl	-0x6c(%rbp), %ecx
               	leaq	-0x20(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movl	%eax, -0x20(%rbp)
               	movl	%ecx, -0x1c(%rbp)
               	movq	-0x20(%rbp), %rax
               	movabsq	$-0x7fffffff80000000, %r11 # imm = 0x8000000080000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb4, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	orq	$0x2000, %rax           # imm = 0x2000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movl	$0x40200000, -0x18(%rbp) # imm = 0x40200000
               	movl	$0xc0200000, -0x14(%rbp) # imm = 0xC0200000
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	leaq	-0x90(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, -0x90(%rbp)
               	movss	-0x14(%rbp), %xmm0
               	movss	%xmm0, -0x8c(%rbp)
               	movss	-0x10(%rbp), %xmm0
               	movss	%xmm0, -0x88(%rbp)
               	movss	-0xc(%rbp), %xmm0
               	movss	%xmm0, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	-0xb0(%rbp), %eax
               	movl	%eax, -0xd0(%rbp)
               	movl	-0xac(%rbp), %eax
               	movl	%eax, -0xcc(%rbp)
               	movl	-0xa0(%rbp), %eax
               	movl	%eax, -0xc8(%rbp)
               	movl	-0x9c(%rbp), %eax
               	movl	%eax, -0xc4(%rbp)
               	leaq	-0xc0(%rbp), %rax
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	leaq	-0x80(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x80(%rbp), %eax
               	movl	-0x7c(%rbp), %ecx
               	leaq	-0x38(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movl	%eax, -0x38(%rbp)
               	movl	%ecx, -0x34(%rbp)
               	movq	-0x38(%rbp), %rax
               	movabsq	$-0x2fffffffe, %r11     # imm = 0xFFFFFFFD00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb6, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	orq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movl	$0x40200000, -0x18(%rbp) # imm = 0x40200000
               	movl	$0xc0200000, -0x14(%rbp) # imm = 0xC0200000
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	leaq	-0x90(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, -0x90(%rbp)
               	movss	-0x14(%rbp), %xmm0
               	movss	%xmm0, -0x8c(%rbp)
               	movss	-0x10(%rbp), %xmm0
               	movss	%xmm0, -0x88(%rbp)
               	movss	-0xc(%rbp), %xmm0
               	movss	%xmm0, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	-0xb0(%rbp), %eax
               	movl	%eax, -0xd0(%rbp)
               	movl	-0xac(%rbp), %eax
               	movl	%eax, -0xcc(%rbp)
               	movl	-0xa0(%rbp), %eax
               	movl	%eax, -0xc8(%rbp)
               	movl	-0x9c(%rbp), %eax
               	movl	%eax, -0xc4(%rbp)
               	leaq	-0xc0(%rbp), %rax
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	leaq	-0x80(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x80(%rbp), %eax
               	movl	-0x7c(%rbp), %ecx
               	leaq	-0x38(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movl	%eax, -0x38(%rbp)
               	movl	%ecx, -0x34(%rbp)
               	movq	-0x38(%rbp), %rax
               	movabsq	$-0x1fffffffd, %r11     # imm = 0xFFFFFFFE00000003
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb8, %eax
               	leave
               	retq
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movl	$0x3f99999a, -0x18(%rbp) # imm = 0x3F99999A
               	movl	$0xbf99999a, -0x14(%rbp) # imm = 0xBF99999A
               	movl	$0x471c4000, -0x10(%rbp) # imm = 0x471C4000
               	movl	$0xc71c4000, -0xc(%rbp) # imm = 0xC71C4000
               	leaq	-0x90(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, -0x90(%rbp)
               	movss	-0x14(%rbp), %xmm0
               	movss	%xmm0, -0x8c(%rbp)
               	movss	-0x10(%rbp), %xmm0
               	movss	%xmm0, -0x88(%rbp)
               	movss	-0xc(%rbp), %xmm0
               	movss	%xmm0, -0x84(%rbp)
               	leaq	-0xc0(%rbp), %r9
               	movups	-0x90(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movsd	%xmm0, -0x48(%rbp)
               	movq	-0x48(%rbp), %rax
               	movabsq	$-0x7fff80000000fffe, %r11 # imm = 0x80007FFFFFFF0002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb9, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	orq	$0x6000, %rax           # imm = 0x6000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movl	$0x40200000, -0x18(%rbp) # imm = 0x40200000
               	movl	$0xc0200000, -0x14(%rbp) # imm = 0xC0200000
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	leaq	-0x90(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, -0x90(%rbp)
               	movss	-0x14(%rbp), %xmm0
               	movss	%xmm0, -0x8c(%rbp)
               	movss	-0x10(%rbp), %xmm0
               	movss	%xmm0, -0x88(%rbp)
               	movss	-0xc(%rbp), %xmm0
               	movss	%xmm0, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	-0xb0(%rbp), %eax
               	movl	%eax, -0xd0(%rbp)
               	movl	-0xac(%rbp), %eax
               	movl	%eax, -0xcc(%rbp)
               	movl	-0xa0(%rbp), %eax
               	movl	%eax, -0xc8(%rbp)
               	movl	-0x9c(%rbp), %eax
               	movl	%eax, -0xc4(%rbp)
               	leaq	-0xc0(%rbp), %rax
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	leaq	-0x80(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x80(%rbp), %eax
               	movl	-0x7c(%rbp), %ecx
               	leaq	-0x38(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movl	%eax, -0x38(%rbp)
               	movl	%ecx, -0x34(%rbp)
               	movq	-0x38(%rbp), %rax
               	movabsq	$-0x1fffffffe, %r11     # imm = 0xFFFFFFFE00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xbb, %eax
               	leave
               	retq
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movl	$0x40200000, -0x18(%rbp) # imm = 0x40200000
               	movl	$0xc0200000, -0x14(%rbp) # imm = 0xC0200000
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	leaq	-0x90(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, -0x90(%rbp)
               	movss	-0x14(%rbp), %xmm0
               	movss	%xmm0, -0x8c(%rbp)
               	movss	-0x10(%rbp), %xmm0
               	movss	%xmm0, -0x88(%rbp)
               	movss	-0xc(%rbp), %xmm0
               	movss	%xmm0, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	-0xb0(%rbp), %eax
               	movl	%eax, -0xd0(%rbp)
               	movl	-0xac(%rbp), %eax
               	movl	%eax, -0xcc(%rbp)
               	movl	-0xa0(%rbp), %eax
               	movl	%eax, -0xc8(%rbp)
               	movl	-0x9c(%rbp), %eax
               	movl	%eax, -0xc4(%rbp)
               	leaq	-0xc0(%rbp), %rax
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	leaq	-0x70(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvttps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x70(%rbp), %eax
               	movl	-0x6c(%rbp), %ecx
               	leaq	-0x20(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movl	%eax, -0x20(%rbp)
               	movl	%ecx, -0x1c(%rbp)
               	movq	-0x20(%rbp), %rax
               	movabsq	$-0x1fffffffe, %r11     # imm = 0xFFFFFFFE00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xbc, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movl	$0x3fc00000, -0x18(%rbp) # imm = 0x3FC00000
               	movl	$0xbfc00000, -0x14(%rbp) # imm = 0xBFC00000
               	movl	$0x471c4000, -0x10(%rbp) # imm = 0x471C4000
               	movl	$0x7fc00000, -0xc(%rbp) # imm = 0x7FC00000
               	leaq	-0x90(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, -0x90(%rbp)
               	movss	-0x14(%rbp), %xmm0
               	movss	%xmm0, -0x8c(%rbp)
               	movss	-0x10(%rbp), %xmm0
               	movss	%xmm0, -0x88(%rbp)
               	movss	-0xc(%rbp), %xmm0
               	movss	%xmm0, -0x84(%rbp)
               	leaq	-0xd0(%rbp), %r9
               	movups	-0x90(%rbp), %xmm0
               	movups	%xmm0, -0xd0(%rbp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movsd	%xmm0, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movabsq	$-0x7fff80000001fffe, %r11 # imm = 0x80007FFFFFFE0002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xbe, %eax
               	leave
               	retq
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movl	$0x43960000, -0x18(%rbp) # imm = 0x43960000
               	movl	$0xc3960000, -0x14(%rbp) # imm = 0xC3960000
               	movl	$0x3f000000, -0x10(%rbp) # imm = 0x3F000000
               	movl	$0xc0e00000, -0xc(%rbp) # imm = 0xC0E00000
               	leaq	-0x90(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, -0x90(%rbp)
               	movss	-0x14(%rbp), %xmm0
               	movss	%xmm0, -0x8c(%rbp)
               	movss	-0x10(%rbp), %xmm0
               	movss	%xmm0, -0x88(%rbp)
               	movss	-0xc(%rbp), %xmm0
               	movss	%xmm0, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	leaq	-0xd0(%rbp), %rax
               	movups	%xmm0, -0xd0(%rbp)
               	leaq	-0x60(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x60(%rbp), %esi
               	movl	-0x5c(%rbp), %eax
               	movl	-0x58(%rbp), %ecx
               	movl	-0x54(%rbp), %edi
               	movq	$0x0, -0x20(%rbp)
               	movl	$0x7f, %edx
               	cmpl	$0x7f, %esi
               	jle	<addr>
               	movb	%dl, -0x20(%rbp)
               	movl	$0x7f, %edx
               	cmpl	$0x7f, %eax
               	jle	<addr>
               	movq	%rdx, %rax
               	movb	%al, -0x1f(%rbp)
               	cmpl	$0x7f, %ecx
               	jle	<addr>
               	movq	%rdx, %rcx
               	movb	%cl, -0x1e(%rbp)
               	cmpl	$0x7f, %edi
               	jle	<addr>
               	movb	%dl, -0x1d(%rbp)
               	movq	-0x20(%rbp), %rax
               	movl	$0xf900807f, %r11d      # imm = 0xF900807F
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xbf, %eax
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rax
               	leaq	<rip>, %rcx # <addr>
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x4b800000, -0xd0(%rbp) # imm = 0x4B800000
               	movl	$0xc0a00000, %eax       # imm = 0xC0A00000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0xcc(%rbp)
               	movss	-0x98(%rbp), %xmm0
               	movss	%xmm0, -0xc8(%rbp)
               	movss	-0x94(%rbp), %xmm0
               	movss	%xmm0, -0xc4(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	movss	-0xc0(%rbp), %xmm0
               	movl	$0x4b800000, %edx       # imm = 0x4B800000
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xbc(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb8(%rbp), %xmm0
               	movl	$0x41100000, %eax       # imm = 0x41100000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb4(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc1, %eax
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rax
               	leaq	<rip>, %rdx # <addr>
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x40c00000, -0xd0(%rbp) # imm = 0x40C00000
               	movl	$0x40e00000, -0xcc(%rbp) # imm = 0x40E00000
               	movss	-0x98(%rbp), %xmm0
               	movss	%xmm0, -0xc8(%rbp)
               	movss	-0x94(%rbp), %xmm0
               	movss	%xmm0, -0xc4(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	movss	-0xc0(%rbp), %xmm0
               	movl	$0x40c00000, %eax       # imm = 0x40C00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xbc(%rbp), %xmm0
               	movl	$0x40e00000, %eax       # imm = 0x40E00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb8(%rbp), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb4(%rbp), %xmm0
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc3, %eax
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xc7000000, -0xd0(%rbp) # imm = 0xC7000000
               	movl	$0x46fffe00, %eax       # imm = 0x46FFFE00
               	movq	%rax, %xmm14
               	movss	%xmm14, -0xcc(%rbp)
               	movl	$0xbf800000, %ecx       # imm = 0xBF800000
               	movq	%rcx, %xmm14
               	movss	%xmm14, -0xc8(%rbp)
               	xorl	%edx, %edx
               	movq	%rdx, %xmm14
               	movss	%xmm14, -0xc4(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	movss	-0xc0(%rbp), %xmm0
               	movl	$0xc7000000, %esi       # imm = 0xC7000000
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xbc(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb8(%rbp), %xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb4(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc5, %eax
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x47000000, -0xd0(%rbp) # imm = 0x47000000
               	movl	$0x46fffe00, %eax       # imm = 0x46FFFE00
               	movq	%rax, %xmm14
               	movss	%xmm14, -0xcc(%rbp)
               	movl	$0x477fff00, %ecx       # imm = 0x477FFF00
               	movq	%rcx, %xmm14
               	movss	%xmm14, -0xc8(%rbp)
               	xorl	%edx, %edx
               	movq	%rdx, %xmm14
               	movss	%xmm14, -0xc4(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	movss	-0xc0(%rbp), %xmm0
               	movl	$0x47000000, %esi       # imm = 0x47000000
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xbc(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb8(%rbp), %xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb4(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc7, %eax
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xc3000000, -0xd0(%rbp) # imm = 0xC3000000
               	movl	$0x42fe0000, %eax       # imm = 0x42FE0000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0xcc(%rbp)
               	movl	$0xbf800000, %ecx       # imm = 0xBF800000
               	movq	%rcx, %xmm14
               	movss	%xmm14, -0xc8(%rbp)
               	movl	$0x40a00000, %edx       # imm = 0x40A00000
               	movq	%rdx, %xmm14
               	movss	%xmm14, -0xc4(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	movss	-0xc0(%rbp), %xmm0
               	movl	$0xc3000000, %esi       # imm = 0xC3000000
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xbc(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb8(%rbp), %xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb4(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc9, %eax
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x43000000, -0xd0(%rbp) # imm = 0x43000000
               	movl	$0x42fe0000, %eax       # imm = 0x42FE0000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0xcc(%rbp)
               	movl	$0x437f0000, %ecx       # imm = 0x437F0000
               	movq	%rcx, %xmm14
               	movss	%xmm14, -0xc8(%rbp)
               	movl	$0x40a00000, %edx       # imm = 0x40A00000
               	movq	%rdx, %xmm14
               	movss	%xmm14, -0xc4(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	movss	-0xc0(%rbp), %xmm0
               	movl	$0x43000000, %esi       # imm = 0x43000000
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xbc(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb8(%rbp), %xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb4(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xcb, %eax
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x3f800000, -0xd0(%rbp) # imm = 0x3F800000
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0xcc(%rbp)
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movq	%rcx, %xmm14
               	movss	%xmm14, -0xc8(%rbp)
               	movl	$0xc0800000, %edx       # imm = 0xC0800000
               	movq	%rdx, %xmm14
               	movss	%xmm14, -0xc4(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	movss	-0xc0(%rbp), %xmm0
               	movl	$0x3f800000, %esi       # imm = 0x3F800000
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xbc(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb8(%rbp), %xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb4(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xcd, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x30(%rbp), %rcx
               	incq	%rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0xd0(%rbp), %rdx
               	leaq	<rip>, %rsi # <addr>
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0xa0(%rbp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0xa0(%rbp), %xmm0
               	movss	%xmm0, -0xd0(%rbp)
               	movss	-0x9c(%rbp), %xmm0
               	movss	%xmm0, -0xcc(%rbp)
               	movss	-0x38(%rbp), %xmm0
               	movss	%xmm0, -0xc8(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	movss	-0x34(%rbp), %xmm0
               	movss	%xmm0, -0xc4(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	movss	-0xc0(%rbp), %xmm0
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xbc(%rbp), %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb8(%rbp), %xmm0
               	movl	$0x3fa00000, %eax       # imm = 0x3FA00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb4(%rbp), %xmm0
               	movl	$0xc0200000, %eax       # imm = 0xC0200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd2, %eax
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rax
               	leaq	<rip>, %rdx # <addr>
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rdx
               	incq	%rdx
               	leaq	-0xa0(%rbp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x38(%rbp), %xmm0
               	movss	%xmm0, -0xd0(%rbp)
               	movss	-0x34(%rbp), %xmm0
               	movss	%xmm0, -0xcc(%rbp)
               	movss	-0x98(%rbp), %xmm0
               	movss	%xmm0, -0xc8(%rbp)
               	movss	-0x94(%rbp), %xmm0
               	movss	%xmm0, -0xc4(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	movss	-0xc0(%rbp), %xmm0
               	movl	$0x3fa00000, %eax       # imm = 0x3FA00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xbc(%rbp), %xmm0
               	movl	$0xc0200000, %eax       # imm = 0xC0200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb8(%rbp), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xb4(%rbp), %xmm0
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd4, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	0x1(%rax), %rdx
               	leaq	-0xa0(%rbp), %rcx
               	leaq	<rip>, %rsi # <addr>
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xd0(%rbp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x38(%rbp), %rcx
               	movq	$0x0, (%rcx)
               	movss	-0xc8(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movss	-0xc4(%rbp), %xmm0
               	movss	%xmm0, -0x34(%rbp)
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	leaq	0x9(%rax), %rcx
               	leaq	-0xa0(%rbp), %rax
               	leaq	<rip>, %rdx # <addr>
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xd0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x38(%rbp), %rax
               	movq	$0x0, (%rax)
               	movss	-0xd0(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movss	-0xcc(%rbp), %xmm0
               	movss	%xmm0, -0x34(%rbp)
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x40(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	incq	%rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x40(%rbp), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x3c(%rbp), %xmm0
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x38(%rbp), %xmm0
               	movl	$0x40a00000, %eax       # imm = 0x40A00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x34(%rbp), %xmm0
               	movl	$0x40c00000, %eax       # imm = 0x40C00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	cmpl	$-0x80, %edi
               	jge	<addr>
               	movq	$-0x80, %rdx
               	jmp	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	cmpl	$-0x80, %ecx
               	jge	<addr>
               	movq	$-0x80, %rcx
               	jmp	<addr>
               	cmpl	$-0x80, %eax
               	jge	<addr>
               	movq	$-0x80, %rax
               	jmp	<addr>
               	cmpl	$-0x80, %esi
               	jge	<addr>
               	movq	$-0x80, %rdx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>

<sse2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movabsq	$-0x123456789abcdf0, %rax # imm = 0xFEDCBA9876543210
               	leaq	-0x60(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rax, -0x60(%rbp)
               	movq	$0x0, -0x58(%rbp)
               	movups	-0x60(%rbp), %xmm0
               	movups	%xmm0, -0x70(%rbp)
               	movq	-0x70(%rbp), %rax
               	movabsq	$-0x123456789abcdf0, %r11 # imm = 0xFEDCBA9876543210
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x68(%rbp)
               	je	<addr>
               	movl	$0xe3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	$0x2, -0x60(%rbp)
               	movq	$0x1, -0x58(%rbp)
               	movups	-0x60(%rbp), %xmm0
               	movups	%xmm0, -0x70(%rbp)
               	movq	-0x70(%rbp), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movq	-0x68(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xe5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	$0x1, -0x60(%rbp)
               	movq	$0x2, -0x58(%rbp)
               	movups	-0x60(%rbp), %xmm0
               	movups	%xmm0, -0x70(%rbp)
               	movq	-0x70(%rbp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	-0x68(%rbp), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xe7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x60(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$0x7, -0x60(%rbp)
               	movq	$0x7, -0x58(%rbp)
               	movups	-0x60(%rbp), %xmm0
               	movups	%xmm0, -0x70(%rbp)
               	movq	-0x70(%rbp), %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movq	-0x68(%rbp), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xe9, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%ebx, %ebx
               	callq	<addr>
               	movq	%rax, %r12
               	callq	<addr>
               	movq	%r12, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movl	-0x28(%rbp), %ecx
               	movl	-0x20(%rbp), %edx
               	imulq	%rdx, %rcx
               	movl	%r12d, %edx
               	movl	%eax, %eax
               	imulq	%rdx, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x7d0, %ebx            # imm = 0x7D0
               	jl	<addr>
               	movabsq	$0x4004000000000000, %rcx # imm = 0x4004000000000000
               	movabsq	$-0x3ff4000000000000, %rdx # imm = 0xC00C000000000000
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	leaq	-0x70(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	-0x18(%rbp), %xmm0
               	movsd	%xmm0, -0x70(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movsd	%xmm0, -0x68(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x60(%rbp), %rax
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtpd2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x50(%rbp), %eax
               	movl	-0x4c(%rbp), %ecx
               	leaq	-0x20(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movl	%eax, -0x20(%rbp)
               	movl	%ecx, -0x1c(%rbp)
               	movq	-0x20(%rbp), %rax
               	movabsq	$-0x3fffffffe, %r11     # imm = 0xFFFFFFFC00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xef, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movabsq	$0x41dfffffffd9999a, %rcx # imm = 0x41DFFFFFFFD9999A
               	movabsq	$-0x3e20000000000000, %rdx # imm = 0xC1E0000000000000
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	leaq	-0x70(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	-0x18(%rbp), %xmm0
               	movsd	%xmm0, -0x70(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movsd	%xmm0, -0x68(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x60(%rbp), %rax
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtpd2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x50(%rbp), %eax
               	movl	-0x4c(%rbp), %ecx
               	leaq	-0x20(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movl	%eax, -0x20(%rbp)
               	movl	%ecx, -0x1c(%rbp)
               	movq	-0x20(%rbp), %rax
               	movabsq	$-0x7fffffff80000001, %r11 # imm = 0x800000007FFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xf0, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movabsq	$0x41e65a0bc0000000, %rcx # imm = 0x41E65A0BC0000000
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movabsq	$0x7ff8000000000000, %rax # imm = 0x7FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	leaq	-0x70(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	-0x18(%rbp), %xmm0
               	movsd	%xmm0, -0x70(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movsd	%xmm0, -0x68(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x60(%rbp), %rax
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtpd2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x50(%rbp), %eax
               	movl	-0x4c(%rbp), %ecx
               	leaq	-0x20(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movl	%eax, -0x20(%rbp)
               	movl	%ecx, -0x1c(%rbp)
               	movq	-0x20(%rbp), %rax
               	movabsq	$-0x7fffffff80000000, %r11 # imm = 0x8000000080000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xf1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	orq	$0x2000, %rax           # imm = 0x2000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movabsq	$0x4004000000000000, %rcx # imm = 0x4004000000000000
               	movabsq	$-0x3ffc000000000000, %rdx # imm = 0xC004000000000000
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	leaq	-0x70(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	-0x18(%rbp), %xmm0
               	movsd	%xmm0, -0x70(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movsd	%xmm0, -0x68(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x60(%rbp), %rax
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtpd2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x50(%rbp), %eax
               	movl	-0x4c(%rbp), %ecx
               	leaq	-0x20(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movl	%eax, -0x20(%rbp)
               	movl	%ecx, -0x1c(%rbp)
               	movq	-0x20(%rbp), %rax
               	movabsq	$-0x2fffffffe, %r11     # imm = 0xFFFFFFFD00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xf3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movabsq	$-0x3ffa666666666666, %rcx # imm = 0xC00599999999999A
               	movabsq	$0x41dffffffff9999a, %rdx # imm = 0x41DFFFFFFFF9999A
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	leaq	-0x70(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	-0x18(%rbp), %xmm0
               	movsd	%xmm0, -0x70(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movsd	%xmm0, -0x68(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x60(%rbp), %rax
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvttpd2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x40(%rbp), %eax
               	movl	-0x3c(%rbp), %ecx
               	leaq	-0x20(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movl	%eax, -0x20(%rbp)
               	movl	%ecx, -0x1c(%rbp)
               	movq	-0x20(%rbp), %rax
               	movabsq	$0x7ffffffffffffffe, %r11 # imm = 0x7FFFFFFFFFFFFFFE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xf5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movabsq	$-0x3e1fffffffe00000, %rcx # imm = 0xC1E0000000200000
               	xorl	%eax, %eax
               	movq	%rax, -0x18(%rbp)
               	movq	%rax, -0x10(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movabsq	$0x7ff8000000000000, %rcx # imm = 0x7FF8000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	leaq	-0x70(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	-0x18(%rbp), %xmm0
               	movsd	%xmm0, -0x70(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movsd	%xmm0, -0x68(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x60(%rbp), %rcx
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	cvttpd2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x40(%rbp), %ecx
               	movl	-0x3c(%rbp), %edx
               	leaq	-0x20(%rbp), %rsi
               	movq	$0x0, (%rsi)
               	movl	%ecx, -0x20(%rbp)
               	movl	%edx, -0x1c(%rbp)
               	movq	-0x20(%rbp), %rcx
               	movabsq	$-0x7fffffff80000000, %r11 # imm = 0x8000000080000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xf6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x60(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movabsq	$0x41dfffffffc00000, %rcx # imm = 0x41DFFFFFFFC00000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x60(%rbp)
               	movabsq	$-0x3e20000000000000, %rdx # imm = 0xC1E0000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x58(%rbp)
               	movups	-0x60(%rbp), %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	movsd	-0x60(%rbp), %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x58(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf8, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0xec, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<ssse3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r10d, %r10d
               	movq	%r10, 0x38(%rsp)
               	callq	<addr>
               	movq	%rax, %rbx
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rbx, -0x38(%rbp)
               	movq	%r12, -0x30(%rbp)
               	xorl	%r15d, %r15d
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%r15,4), %rcx
               	movl	$0x40, %eax
               	cltd
               	idivl	%ecx
               	movq	%rax, %r13
               	xorl	%esi, %esi
               	movq	%rsi, %r8
               	movq	%rsi, %r9
               	cmpl	%r13d, %esi
               	jge	<addr>
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	movq	%rbx, %rdx
               	cmpl	$0x40, %ecx
               	jge	<addr>
               	leaq	-0x1(%rcx), %rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	shlxq	%rcx, %rax, %rax
               	subq	%rax, %rdx
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	movq	%r12, %rdi
               	cmpl	$0x40, %ecx
               	jge	<addr>
               	leaq	-0x1(%rcx), %rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rdi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	shlxq	%rcx, %rax, %rax
               	subq	%rax, %rdi
               	testq	%rdx, %rdx
               	jge	<addr>
               	movq	%rdx, %rax
               	negq	%rax
               	movl	$0x1, %r14d
               	shlxq	%rcx, %r14, %r14
               	decq	%r14
               	andq	%r14, %rax
               	movq	%rcx, %r14
               	imulq	%rsi, %r14
               	movslq	%r14d, %r14
               	shlxq	%r14, %rax, %rax
               	orq	%rax, %r9
               	testq	%rdi, %rdi
               	jge	<addr>
               	negq	%rdx
               	jmp	<addr>
               	testq	%rdi, %rdi
               	jne	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	shrxq	%rax, %r12, %rdi
               	movl	$0x1, %eax
               	shlxq	%rcx, %rax, %rax
               	decq	%rax
               	andq	%rax, %rdi
               	jmp	<addr>
               	movq	%rcx, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rbx, %rdx
               	movl	$0x1, %eax
               	shlxq	%rcx, %rax, %rax
               	decq	%rax
               	andq	%rax, %rdx
               	jmp	<addr>
               	movl	$0x1, %eax
               	shlxq	%rcx, %rax, %rax
               	decq	%rax
               	andq	%rdx, %rax
               	movq	%rcx, %rdx
               	imulq	%rsi, %rdx
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rax, %rax
               	orq	%rax, %r8
               	incq	%rsi
               	cmpl	%r13d, %esi
               	jl	<addr>
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x28(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	xorl	%eax, %eax
               	leaq	-0x18(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movsbq	(%rdx,%rax), %rdx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movsbq	(%rdx,%rax), %rdx
               	negq	%rdx
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movsbq	(%rdx,%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x18(%rbp), %rsi
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	leaq	-0x8(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	movsbq	(%rcx,%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movsbq	(%rcx,%rax), %rcx
               	negq	%rcx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movsbq	(%rcx,%rax), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	%r9, %rsi
               	jne	<addr>
               	cmpq	%r8, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0x10, %ecx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	leaq	-0x8(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	negq	%rcx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	cmpw	$0x0, (%rcx,%rax,2)
               	je	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, (%rdx,%rax,2)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x8(%rbp), %rax
               	jmp	<addr>
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	leaq	-0x8(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	negq	%rcx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	cmpl	$0x0, (%rcx,%rax,4)
               	je	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movq	-0x8(%rbp), %rax
               	jmp	<addr>
               	cmpl	$0x10, %ecx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x28(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	xorl	%eax, %eax
               	leaq	-0x18(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movswq	(%rdx,%rax,2), %rdx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movswq	(%rdx,%rax,2), %rdx
               	negq	%rdx
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movswq	(%rdx,%rax,2), %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%rsi,%rax,2)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x18(%rbp), %rsi
               	jmp	<addr>
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x28(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	xorl	%eax, %eax
               	leaq	-0x18(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	negq	%rdx
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	movl	%edx, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movq	-0x18(%rbp), %rsi
               	jmp	<addr>
               	incq	%r15
               	cmpl	$0x3, %r15d
               	jl	<addr>
               	xorl	%r8d, %r8d
               	movq	%rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	shrq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	subq	$0x10000, %rax          # imm = 0x10000
               	movq	%rbx, %rcx
               	shrq	$0x10, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rdx
               	shrq	$0xf, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	subq	$0x10000, %rcx          # imm = 0x10000
               	movq	%r12, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	shrq	$0xf, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	subq	$0x10000, %rdx          # imm = 0x10000
               	movq	%r12, %rsi
               	shrq	$0x10, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movq	%rsi, %rdi
               	shrq	$0xf, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	subq	$0x10000, %rsi          # imm = 0x10000
               	leaq	(%rax,%rcx), %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	orq	%r8, %rdi
               	leaq	(%rdx,%rsi), %r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	shlq	$0x20, %r9
               	movq	%rdi, %r13
               	orq	%r9, %r13
               	leaq	(%rax,%rcx), %r9
               	movl	$0x7fff, %edi           # imm = 0x7FFF
               	cmpl	%edi, %r9d
               	jle	<addr>
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movq	%r8, %r14
               	orq	%rdi, %r14
               	leaq	(%rdx,%rsi), %r9
               	movl	$0x7fff, %edi           # imm = 0x7FFF
               	cmpl	%edi, %r9d
               	jle	<addr>
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	shlq	$0x20, %rdi
               	movq	%r14, %r9
               	orq	%rdi, %r9
               	movq	%rax, %rdi
               	subq	%rcx, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	orq	%r8, %rdi
               	movq	%rdx, %r14
               	subq	%rsi, %r14
               	andq	$0xffff, %r14           # imm = 0xFFFF
               	shlq	$0x20, %r14
               	orq	%rdi, %r14
               	movq	%rax, %rdi
               	subq	%rcx, %rdi
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %edi
               	jle	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%r8, %rdi
               	orq	%rax, %rdi
               	movq	%rdx, %rcx
               	subq	%rsi, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0x20, %rax
               	movq	%rdi, %r15
               	orq	%rax, %r15
               	movq	%rbx, %rax
               	shrq	$0x20, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	shrq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	subq	$0x10000, %rax          # imm = 0x10000
               	movq	%rbx, %rcx
               	shrq	$0x30, %rcx
               	movq	%rcx, %rdx
               	shrq	$0xf, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	subq	$0x10000, %rcx          # imm = 0x10000
               	movq	%r12, %rdx
               	shrq	$0x20, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	shrq	$0xf, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	subq	$0x10000, %rdx          # imm = 0x10000
               	movq	%r12, %rsi
               	shrq	$0x30, %rsi
               	movq	%rsi, %rdi
               	shrq	$0xf, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	subq	$0x10000, %rsi          # imm = 0x10000
               	leaq	(%rax,%rcx), %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	shlq	$0x10, %rdi
               	orq	%r13, %rdi
               	leaq	(%rdx,%rsi), %r8
               	shlq	$0x30, %r8
               	movq	%rdi, %r13
               	orq	%r8, %r13
               	leaq	(%rax,%rcx), %r8
               	movl	$0x7fff, %edi           # imm = 0x7FFF
               	cmpl	%edi, %r8d
               	jle	<addr>
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	shlq	$0x10, %rdi
               	orq	%rdi, %r9
               	leaq	(%rdx,%rsi), %r8
               	movl	$0x7fff, %edi           # imm = 0x7FFF
               	cmpl	%edi, %r8d
               	jle	<addr>
               	shlq	$0x30, %rdi
               	movq	%r9, %r8
               	orq	%rdi, %r8
               	movq	%rax, %rdi
               	subq	%rcx, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	shlq	$0x10, %rdi
               	orq	%r14, %rdi
               	movq	%rdx, %r9
               	subq	%rsi, %r9
               	shlq	$0x30, %r9
               	orq	%rdi, %r9
               	movq	%rax, %rdi
               	subq	%rcx, %rdi
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %edi
               	jle	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0x10, %rax
               	movq	%r15, %rdi
               	orq	%rax, %rdi
               	movq	%rdx, %rcx
               	subq	%rsi, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	shlq	$0x30, %rax
               	movq	%rdi, %rsi
               	orq	%rax, %rsi
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x8(%rbp), %rax
               	movq	$0x0, (%rax)
               	movzwq	-0x18(%rbp), %rax
               	movzwq	-0x16(%rbp), %rcx
               	addq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x8(%rbp)
               	movzwq	-0x14(%rbp), %rax
               	movzwq	-0x12(%rbp), %rcx
               	addq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x6(%rbp)
               	movzwq	-0x10(%rbp), %rax
               	movzwq	-0xe(%rbp), %rcx
               	addq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x4(%rbp)
               	movzwq	-0xc(%rbp), %rax
               	movzwq	-0xa(%rbp), %rcx
               	addq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x2(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%r13, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x8(%rbp), %rax
               	movq	$0x0, (%rax)
               	movswq	-0x18(%rbp), %rax
               	movswq	-0x16(%rbp), %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x8(%rbp)
               	movswq	-0x14(%rbp), %rax
               	movswq	-0x12(%rbp), %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x6(%rbp)
               	movswq	-0x10(%rbp), %rax
               	movswq	-0xe(%rbp), %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x4(%rbp)
               	movswq	-0xc(%rbp), %rax
               	movswq	-0xa(%rbp), %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x2(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%r8, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x18(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x8(%rbp), %rax
               	movq	$0x0, (%rax)
               	movzwq	-0x18(%rbp), %rax
               	movzwq	-0x16(%rbp), %rcx
               	subq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x8(%rbp)
               	movzwq	-0x14(%rbp), %rax
               	movzwq	-0x12(%rbp), %rcx
               	subq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x6(%rbp)
               	movzwq	-0x10(%rbp), %rax
               	movzwq	-0xe(%rbp), %rcx
               	subq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x4(%rbp)
               	movzwq	-0xc(%rbp), %rax
               	movzwq	-0xa(%rbp), %rcx
               	subq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x2(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%r9, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x28(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	$0x0, (%rax)
               	movswq	-0x18(%rbp), %rcx
               	movswq	-0x16(%rbp), %rax
               	subq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x8(%rbp)
               	movswq	-0x14(%rbp), %rcx
               	movswq	-0x12(%rbp), %rax
               	subq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movq	%rax, %rcx
               	movw	%cx, -0x6(%rbp)
               	movswq	-0x10(%rbp), %rcx
               	movswq	-0xe(%rbp), %rdx
               	subq	%rdx, %rcx
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x4(%rbp)
               	movswq	-0xc(%rbp), %rcx
               	movswq	-0xa(%rbp), %rax
               	subq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x2(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	%ebx, %eax
               	movq	%rax, %rcx
               	shrq	$0x1f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	subq	%r11, %rax
               	movq	%rbx, %rcx
               	shrq	$0x20, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x1f, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	subq	%r11, %rcx
               	addq	%rcx, %rax
               	movl	%eax, %edx
               	movl	%r12d, %eax
               	movq	%rax, %rcx
               	shrq	$0x1f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	subq	%r11, %rax
               	movq	%r12, %rcx
               	shrq	$0x20, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x1f, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	subq	%r11, %rcx
               	addq	%rcx, %rax
               	shlq	$0x20, %rax
               	orq	%rax, %rdx
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x28(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rsi), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rsi
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	$0x0, (%rax)
               	movl	-0x18(%rbp), %eax
               	movl	-0x14(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x10(%rbp), %eax
               	movl	-0xc(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0x4(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movl	%ebx, %eax
               	movq	%rax, %rcx
               	shrq	$0x1f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	subq	%r11, %rax
               	movq	%rbx, %rcx
               	shrq	$0x20, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x1f, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	subq	%r11, %rcx
               	subq	%rcx, %rax
               	movl	%eax, %edx
               	movl	%r12d, %eax
               	movq	%rax, %rcx
               	shrq	$0x1f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	subq	%r11, %rax
               	movq	%r12, %rcx
               	shrq	$0x20, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x1f, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	subq	%r11, %rcx
               	subq	%rcx, %rax
               	shlq	$0x20, %rax
               	orq	%rax, %rdx
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x28(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rsi), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rsi
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	$0x0, (%rax)
               	movl	-0x18(%rbp), %eax
               	movl	-0x14(%rbp), %ecx
               	subq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x10(%rbp), %eax
               	movl	-0xc(%rbp), %ecx
               	subq	%rcx, %rax
               	movl	%eax, -0x4(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	%rbx, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rdx
               	shrq	$0x7, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	subq	$0x100, %rax            # imm = 0x100
               	imulq	%rax, %rcx
               	movq	%rbx, %rax
               	shrq	$0x8, %rax
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	movq	%r12, %rax
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rsi
               	shrq	$0x7, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	subq	$0x100, %rax            # imm = 0x100
               	imulq	%rdx, %rax
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpq	%rax, %rcx
               	jle	<addr>
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rbx, %rax
               	shrq	$0x10, %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %rax
               	shrq	$0x10, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rsi
               	shrq	$0x7, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	subq	$0x100, %rax            # imm = 0x100
               	imulq	%rax, %rcx
               	movq	%rbx, %rax
               	shrq	$0x18, %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	movq	%r12, %rax
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rdi
               	shrq	$0x7, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	subq	$0x100, %rax            # imm = 0x100
               	imulq	%rsi, %rax
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpq	%rax, %rcx
               	jle	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0x10, %rax
               	orq	%rax, %rdx
               	movq	%rbx, %rax
               	shrq	$0x20, %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %rax
               	shrq	$0x20, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rsi
               	shrq	$0x7, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	subq	$0x100, %rax            # imm = 0x100
               	imulq	%rax, %rcx
               	movq	%rbx, %rax
               	shrq	$0x28, %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	movq	%r12, %rax
               	shrq	$0x28, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rdi
               	shrq	$0x7, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	subq	$0x100, %rax            # imm = 0x100
               	imulq	%rsi, %rax
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpq	%rax, %rcx
               	jle	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0x20, %rax
               	orq	%rax, %rdx
               	movq	%rbx, %rax
               	shrq	$0x30, %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %rax
               	shrq	$0x30, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rsi
               	shrq	$0x7, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	subq	$0x100, %rax            # imm = 0x100
               	imulq	%rax, %rcx
               	movq	%rbx, %rsi
               	shrq	$0x38, %rsi
               	movq	%r12, %rax
               	shrq	$0x38, %rax
               	movq	%rax, %rdi
               	shrq	$0x7, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	subq	$0x100, %rax            # imm = 0x100
               	imulq	%rsi, %rax
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpq	%rax, %rcx
               	jle	<addr>
               	shlq	$0x30, %rax
               	orq	%rax, %rdx
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x28(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rsi), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rsi
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movzbq	-0x18(%rbp), %rax
               	movsbq	-0x10(%rbp), %rcx
               	imulq	%rcx, %rax
               	movzbq	-0x17(%rbp), %rcx
               	movsbq	-0xf(%rbp), %rsi
               	imulq	%rsi, %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x8(%rbp)
               	movzbq	-0x16(%rbp), %rax
               	movsbq	-0xe(%rbp), %rcx
               	imulq	%rcx, %rax
               	movzbq	-0x15(%rbp), %rcx
               	movsbq	-0xd(%rbp), %rsi
               	imulq	%rsi, %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x6(%rbp)
               	movzbq	-0x14(%rbp), %rax
               	movsbq	-0xc(%rbp), %rcx
               	imulq	%rcx, %rax
               	movzbq	-0x13(%rbp), %rcx
               	movsbq	-0xb(%rbp), %rsi
               	imulq	%rsi, %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x4(%rbp)
               	movzbq	-0x12(%rbp), %rax
               	movsbq	-0xa(%rbp), %rcx
               	imulq	%rcx, %rax
               	movzbq	-0x11(%rbp), %rcx
               	movsbq	-0x9(%rbp), %rsi
               	imulq	%rsi, %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x2(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	%rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	shrq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	subq	$0x10000, %rax          # imm = 0x10000
               	movq	%r12, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rdx
               	shrq	$0xf, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	subq	$0x10000, %rcx          # imm = 0x10000
               	imulq	%rcx, %rax
               	sarq	$0xe, %rax
               	incq	%rax
               	sarq	%rax
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rbx, %rax
               	shrq	$0x10, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	shrq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	subq	$0x10000, %rax          # imm = 0x10000
               	movq	%r12, %rcx
               	shrq	$0x10, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rsi
               	shrq	$0xf, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	subq	$0x10000, %rcx          # imm = 0x10000
               	imulq	%rcx, %rax
               	sarq	$0xe, %rax
               	incq	%rax
               	sarq	%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0x10, %rax
               	orq	%rax, %rdx
               	movq	%rbx, %rax
               	shrq	$0x20, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	shrq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	subq	$0x10000, %rax          # imm = 0x10000
               	movq	%r12, %rcx
               	shrq	$0x20, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rsi
               	shrq	$0xf, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	subq	$0x10000, %rcx          # imm = 0x10000
               	imulq	%rcx, %rax
               	sarq	$0xe, %rax
               	incq	%rax
               	sarq	%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0x20, %rax
               	orq	%rax, %rdx
               	movq	%rbx, %rax
               	shrq	$0x30, %rax
               	movq	%rax, %rcx
               	shrq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	subq	$0x10000, %rax          # imm = 0x10000
               	movq	%r12, %rcx
               	shrq	$0x30, %rcx
               	movq	%rcx, %rsi
               	shrq	$0xf, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	subq	$0x10000, %rcx          # imm = 0x10000
               	imulq	%rcx, %rax
               	sarq	$0xe, %rax
               	incq	%rax
               	sarq	%rax
               	shlq	$0x30, %rax
               	orq	%rax, %rdx
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x28(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rsi), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rsi
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movswq	-0x18(%rbp), %rax
               	movswq	-0x10(%rbp), %rcx
               	imulq	%rcx, %rax
               	movslq	%eax, %rax
               	sarq	$0xe, %rax
               	incq	%rax
               	sarq	%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x8(%rbp)
               	movswq	-0x16(%rbp), %rax
               	movswq	-0xe(%rbp), %rcx
               	imulq	%rcx, %rax
               	movslq	%eax, %rax
               	sarq	$0xe, %rax
               	incq	%rax
               	sarq	%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x6(%rbp)
               	movswq	-0x14(%rbp), %rax
               	movswq	-0xc(%rbp), %rcx
               	imulq	%rcx, %rax
               	movslq	%eax, %rax
               	sarq	$0xe, %rax
               	incq	%rax
               	sarq	%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x4(%rbp)
               	movswq	-0x12(%rbp), %rax
               	movswq	-0xa(%rbp), %rcx
               	imulq	%rcx, %rax
               	movslq	%eax, %rax
               	sarq	$0xe, %rax
               	incq	%rax
               	sarq	%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x2(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rdi
               	shrxq	%rdi, %r12, %rdi
               	movq	%rdi, %r8
               	andq	$0xff, %r8
               	testb	$-0x80, %r8b
               	je	<addr>
               	movq	%rcx, %rdi
               	jmp	<addr>
               	andq	$0xff, %rdi
               	andq	$0x7, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rbx, %rdi
               	andq	$0xff, %rdi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rdi, %rsi
               	orq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x28(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rsi), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rsi
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rsi
               	leaq	-0x8(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	testb	$-0x80, %cl
               	je	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdi
               	movzbq	(%rdi,%rax), %rdi
               	andq	$0x7, %rdi
               	movsbq	(%rcx,%rdi), %rcx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x28(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	leaq	-0x8(%rbp), %rdx
               	movzbq	(%rcx,%rax), %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x8(%rbp), %r13
               	xorl	%edx, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x28(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rcx), %r10
               	movq	%r10, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x1(%rax), %rcx
               	leaq	-0x8(%rbp), %rdi
               	cmpl	$0x8, %ecx
               	jae	<addr>
               	movzbq	(%rsi,%rcx), %rdx
               	jmp	<addr>
               	movzbq	-0x18(%rbp), %rdx
               	movb	%dl, (%rdi,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x8(%rbp), %r13
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x28(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x5(%rax), %rcx
               	leaq	-0x8(%rbp), %rsi
               	cmpl	$0x8, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rcx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdi
               	subq	$0x8, %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x8(%rbp), %r13
               	movl	$0x5, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x28(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rcx
               	leaq	-0x8(%rbp), %rsi
               	cmpl	$0x8, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rcx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdi
               	subq	$0x8, %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x8(%rbp), %r13
               	movl	$0x8, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x28(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x9(%rax), %rcx
               	leaq	-0x8(%rbp), %rsi
               	cmpl	$0x8, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rcx
               	jmp	<addr>
               	cmpl	$0x10, %ecx
               	jae	<addr>
               	leaq	-0x18(%rbp), %rdi
               	subq	$0x8, %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x8(%rbp), %r13
               	movl	$0x9, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x28(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	xorl	%eax, %eax
               	leaq	0xf(%rax), %rcx
               	leaq	-0x8(%rbp), %rsi
               	cmpl	$0x8, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rcx
               	jmp	<addr>
               	cmpl	$0x10, %ecx
               	jae	<addr>
               	leaq	-0x18(%rbp), %rdi
               	subq	$0x8, %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x8(%rbp), %r13
               	movl	$0xf, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x28(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rcx
               	leaq	-0x8(%rbp), %rsi
               	cmpl	$0x8, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rcx
               	jmp	<addr>
               	cmpl	$0x10, %ecx
               	jae	<addr>
               	leaq	-0x18(%rbp), %rdi
               	subq	$0x8, %rcx
               	movl	%ecx, %ecx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x8(%rbp), %r13
               	movl	$0x10, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x28(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x14(%rax), %rcx
               	leaq	-0x8(%rbp), %rsi
               	cmpl	$0x8, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rcx
               	jmp	<addr>
               	cmpl	$0x10, %ecx
               	jae	<addr>
               	leaq	-0x18(%rbp), %rdi
               	subq	$0x8, %rcx
               	movl	%ecx, %ecx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x8(%rbp), %r13
               	movl	$0x14, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	%rax, %r13
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpq	$-0x8000, %rcx          # imm = 0x8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpq	$-0x8000, %rcx          # imm = 0x8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpq	$-0x8000, %rcx          # imm = 0x8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpq	$-0x8000, %rcx          # imm = 0x8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rcx          # imm = 0x8000
               	jmp	<addr>
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %edi       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rdi, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %r8d       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rdi          # imm = 0x8000
               	jmp	<addr>
               	movq	%r8, %rdi
               	jmp	<addr>
               	cmpl	$0xffff8000, %r8d       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rdi          # imm = 0x8000
               	jmp	<addr>
               	movq	%r8, %rdi
               	jmp	<addr>
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %edi       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	jmp	<addr>
               	movq	%rdi, %rax
               	jmp	<addr>
               	cmpl	$0xffff8000, %r9d       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rdi          # imm = 0x8000
               	jmp	<addr>
               	movq	%r9, %rdi
               	jmp	<addr>
               	cmpl	$0xffff8000, %r9d       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rdi          # imm = 0x8000
               	jmp	<addr>
               	movq	%r9, %rdi
               	jmp	<addr>
               	movq	0x38(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %rax
               	cmpl	$0x7d0, %eax            # imm = 0x7D0
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x139, %eax            # imm = 0x139
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x138, %eax            # imm = 0x138
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x137, %eax            # imm = 0x137
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x136, %eax            # imm = 0x136
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x135, %eax            # imm = 0x135
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x134, %eax            # imm = 0x134
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x133, %eax            # imm = 0x133
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x132, %eax            # imm = 0x132
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x130, %eax            # imm = 0x130
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x12b, %eax            # imm = 0x12B
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x127, %eax            # imm = 0x127
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x120, %eax            # imm = 0x120
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x11d, %eax            # imm = 0x11D
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x11a, %eax            # imm = 0x11A
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x119, %eax            # imm = 0x119
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x10e, %eax            # imm = 0x10E
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	popq	%rbp
               	retq

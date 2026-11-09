
avx2_shifts_shuffles_and_blends_follow_the_sdm.x64:	file format elf64-x86-64

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

<_mm256_mpsadbw_epu8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movslq	%esi, %r13
               	movq	-0x20(%rbp), %r12
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	leaq	0x40(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movups	0x40(%rsp), %xmm0
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	leaq	0x40(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movups	0x40(%rsp), %xmm1
               	movups	%xmm0, 0x50(%rsp)
               	movups	%xmm1, 0x60(%rsp)
               	movq	%r13, %rax
               	sarq	$0x2, %rax
               	andq	$0x1, %rax
               	movq	%rax, %r9
               	shlq	$0x2, %r9
               	movq	%r13, %rax
               	andq	$0x3, %rax
               	shlq	$0x2, %rax
               	xorl	%r8d, %r8d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdi
               	leaq	0x50(%rsp), %rdx
               	leaq	(%r9,%r8), %rsi
               	addq	%rcx, %rsi
               	movsbq	(%rdx,%rsi), %rdx
               	andq	$0xff, %rdx
               	leaq	0x60(%rsp), %rsi
               	leaq	(%rax,%rcx), %rbx
               	movsbq	(%rsi,%rbx), %rsi
               	andq	$0xff, %rsi
               	subq	%rsi, %rdx
               	testl	%edx, %edx
               	jge	<addr>
               	negq	%rdx
               	addq	%rdx, %rdi
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	0x70(%rsp), %rcx
               	movw	%di, (%rcx,%r8,2)
               	incq	%r8
               	cmpl	$0x8, %r8d
               	jl	<addr>
               	movups	0x70(%rsp), %xmm0
               	movq	0x10(%rsp), %rax
               	movq	0x18(%rsp), %rcx
               	leaq	0x40(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movups	0x40(%rsp), %xmm1
               	movq	0x30(%rsp), %rax
               	movq	0x38(%rsp), %rcx
               	leaq	0x40(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movups	0x40(%rsp), %xmm2
               	movq	%r13, %rax
               	sarq	$0x3, %rax
               	movups	%xmm1, 0x50(%rsp)
               	movups	%xmm2, 0x60(%rsp)
               	movq	%rax, %rcx
               	sarq	$0x2, %rcx
               	andq	$0x1, %rcx
               	movq	%rcx, %r8
               	shlq	$0x2, %r8
               	andq	$0x3, %rax
               	movq	%rax, %r9
               	shlq	$0x2, %r9
               	xorl	%edi, %edi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	leaq	0x50(%rsp), %rdx
               	leaq	(%r8,%rdi), %rax
               	addq	%rcx, %rax
               	movsbq	(%rdx,%rax), %rdx
               	andq	$0xff, %rdx
               	leaq	0x60(%rsp), %rax
               	leaq	(%r9,%rcx), %rbx
               	movsbq	(%rax,%rbx), %rax
               	andq	$0xff, %rax
               	subq	%rax, %rdx
               	testl	%edx, %edx
               	jge	<addr>
               	negq	%rdx
               	addq	%rdx, %rsi
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	0x70(%rsp), %rcx
               	movw	%si, (%rcx,%rdi,2)
               	incq	%rdi
               	cmpl	$0x8, %edi
               	jl	<addr>
               	movups	0x70(%rsp), %xmm1
               	movups	%xmm0, 0x70(%rsp)
               	movups	%xmm1, 0x40(%rsp)
               	movq	0x70(%rsp), %rax
               	movq	0x78(%rsp), %rcx
               	movq	0x40(%rsp), %rdx
               	movq	0x48(%rsp), %rsi
               	movq	%rax, (%r12)
               	movq	%rcx, 0x8(%r12)
               	movq	%rdx, 0x10(%r12)
               	movq	%rsi, 0x18(%r12)
               	movq	%r12, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<next>:
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	retq

<lane>:
               	movslq	%ecx, %rcx
               	xorl	%eax, %eax
               	leaq	-0x1(%rsi), %r8
               	testl	%r8d, %r8d
               	jl	<addr>
               	shlq	$0x8, %rax
               	movq	%rsi, %r9
               	imulq	%rdx, %r9
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rax
               	decq	%r8
               	testl	%r8d, %r8d
               	jge	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	$0x8, %esi
               	jge	<addr>
               	shlq	$0x3, %rsi
               	leaq	-0x1(%rsi), %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rax, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movq	$-0x1, %rcx
               	movslq	%esi, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	orq	%rcx, %rax
               	retq

<set_lane>:
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	movq	%rsi, %r8
               	imulq	%rdx, %r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdi,%r8)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	retq

<same>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rdi, %rsi
               	leaq	-0x20(%rbp), %rdi
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<same128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movups	%xmm0, -0x20(%rbp)
               	movq	%rdi, %rsi
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x20(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<shift>:
               	movq	%rsi, %rax
               	shlq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpl	$0x8, %esi
               	jne	<addr>
               	movq	$-0x1, %rsi
               	andq	%rdi, %rsi
               	testl	%edx, %edx
               	jne	<addr>
               	cmpq	%rax, %rcx
               	jb	<addr>
               	xorl	%eax, %eax
               	retq
               	shlxq	%rcx, %rsi, %rax
               	jmp	<addr>
               	cmpl	$0x1, %edx
               	jne	<addr>
               	cmpq	%rax, %rcx
               	jb	<addr>
               	xorl	%eax, %eax
               	retq
               	shrxq	%rcx, %rsi, %rax
               	jmp	<addr>
               	cmpq	%rax, %rcx
               	jb	<addr>
               	decq	%rax
               	movslq	%eax, %rax
               	sarxq	%rax, %rdi, %rax
               	retq
               	movslq	%ecx, %rax
               	jmp	<addr>
               	movl	$0x1, %esi
               	shlxq	%rax, %rsi, %rsi
               	decq	%rsi
               	jmp	<addr>

<model_shift>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x20, %r14d
               	movq	%rdx, %rbx
               	movq	%rcx, %r13
               	xorl	%r12d, %r12d
               	movl	%r14d, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %r12d
               	jge	<addr>
               	cmpl	$0x2, %r13d
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	leaq	-0x1(%rbx), %rsi
               	testl	%esi, %esi
               	jl	<addr>
               	movq	%rax, %rdx
               	shlq	$0x8, %rdx
               	movq	%rbx, %rax
               	imulq	%r12, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	movzbq	(%rdi,%rax), %rax
               	orq	%rdx, %rax
               	decq	%rsi
               	testl	%esi, %esi
               	jge	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	$0x8, %ebx
               	jge	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rax, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movq	$-0x1, %rcx
               	movq	%rbx, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rdx
               	cmpl	$0x8, %ebx
               	jne	<addr>
               	movq	$-0x1, %rcx
               	andq	%rax, %rcx
               	testl	%r13d, %r13d
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jb	<addr>
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	cmpl	%ebx, %esi
               	jge	<addr>
               	movq	%rbx, %rax
               	imulq	%r12, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%r9,%rax)
               	incq	%rsi
               	cmpl	%ebx, %esi
               	jge	<addr>
               	jmp	<addr>
               	shlxq	%r8, %rcx, %rdx
               	jmp	<addr>
               	cmpl	$0x1, %r13d
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jb	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	shrxq	%r8, %rcx, %rdx
               	jmp	<addr>
               	cmpq	%rdx, %r8
               	jb	<addr>
               	leaq	-0x1(%rdx), %rcx
               	movslq	%ecx, %rcx
               	sarxq	%rcx, %rax, %rdx
               	jmp	<addr>
               	movslq	%r8d, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	shlxq	%rdx, %rcx, %rcx
               	decq	%rcx
               	jmp	<addr>
               	incq	%r12
               	movl	%r14d, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %r12d
               	jl	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq

<check_count_shifts>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x200, %rsp            # imm = 0x200
               	andq	$-0x20, %rsp
               	movq	%rdi, %r12
               	movq	%rsi, -0x68(%rbp)
               	leaq	(%rsp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r12), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	(%rsp), %r13
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	0x18(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	xorl	%ebx, %ebx
               	movq	%rbx, -0x60(%rbp)
               	leaq	-0x48(%rbp), %rax
               	movq	-0x68(%rbp), %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rax)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %rax
               	leaq	(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movups	%xmm14, 0x20(%rcx)
               	movups	%xmm14, 0x30(%rcx)
               	movups	%xmm14, 0x40(%rcx)
               	movups	%xmm14, 0x50(%rcx)
               	movups	%xmm14, 0x60(%rcx)
               	movups	%xmm14, 0x70(%rcx)
               	movups	%xmm14, 0x80(%rcx)
               	movups	%xmm14, 0x90(%rcx)
               	movups	%xmm14, 0xa0(%rcx)
               	movups	%xmm14, 0xb0(%rcx)
               	movups	%xmm14, 0xc0(%rcx)
               	movups	%xmm14, 0xd0(%rcx)
               	movups	%xmm14, 0xe0(%rcx)
               	movups	%xmm14, 0xf0(%rcx)
               	leaq	0x120(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r13, 0x120(%rsp)
               	movq	%r14, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	movups	%xmm0, 0x130(%rsp)
               	leaq	0x130(%rsp), %rdx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	leaq	0x140(%rsp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	psllw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	0x140(%rsp), %xmm0
               	leaq	0x150(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r15, 0x150(%rsp)
               	movq	-0x58(%rbp), %r10
               	movq	%r10, 0x158(%rsp)
               	movups	0x150(%rsp), %xmm1
               	movups	%xmm1, 0x130(%rsp)
               	leaq	0x130(%rsp), %rdx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	leaq	0x140(%rsp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	psllw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	0x140(%rsp), %xmm1
               	movups	%xmm0, 0x160(%rsp)
               	movups	%xmm1, 0x170(%rsp)
               	movq	0x160(%rsp), %rcx
               	movq	0x168(%rsp), %rdx
               	movq	0x170(%rsp), %rsi
               	movq	0x178(%rsp), %rdi
               	movq	%rcx, (%rsp)
               	movq	%rdx, 0x8(%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdi, 0x18(%rsp)
               	leaq	0x120(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r13, 0x120(%rsp)
               	movq	%r14, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	movups	%xmm0, 0x180(%rsp)
               	leaq	0x180(%rsp), %rdx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	leaq	0x190(%rsp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	pslld	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	0x190(%rsp), %xmm0
               	leaq	0x150(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r15, 0x150(%rsp)
               	movq	-0x58(%rbp), %r10
               	movq	%r10, 0x158(%rsp)
               	movups	0x150(%rsp), %xmm1
               	movups	%xmm1, 0x180(%rsp)
               	leaq	0x180(%rsp), %rdx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	leaq	0x190(%rsp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	pslld	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	0x190(%rsp), %xmm1
               	movups	%xmm0, 0x160(%rsp)
               	movups	%xmm1, 0x170(%rsp)
               	movq	0x160(%rsp), %rdx
               	movq	0x168(%rsp), %rsi
               	movq	0x170(%rsp), %rdi
               	movq	0x178(%rsp), %r8
               	leaq	(%rsp), %rcx
               	addq	$0x20, %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdi, 0x10(%rcx)
               	movq	%r8, 0x18(%rcx)
               	leaq	0x120(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r13, 0x120(%rsp)
               	movq	%r14, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	movups	%xmm0, 0x130(%rsp)
               	leaq	0x130(%rsp), %rdx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	leaq	0x1a0(%rsp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	psllq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	0x1a0(%rsp), %xmm0
               	leaq	0x150(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r15, 0x150(%rsp)
               	movq	-0x58(%rbp), %r10
               	movq	%r10, 0x158(%rsp)
               	movups	0x150(%rsp), %xmm1
               	movups	%xmm1, 0x130(%rsp)
               	leaq	0x130(%rsp), %rdx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	leaq	0x1a0(%rsp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	psllq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	0x1a0(%rsp), %xmm1
               	movups	%xmm0, 0x160(%rsp)
               	movups	%xmm1, 0x170(%rsp)
               	movq	0x160(%rsp), %rdx
               	movq	0x168(%rsp), %rsi
               	movq	0x170(%rsp), %rdi
               	movq	0x178(%rsp), %r8
               	leaq	(%rsp), %rcx
               	addq	$0x40, %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdi, 0x10(%rcx)
               	movq	%r8, 0x18(%rcx)
               	leaq	0x120(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r13, 0x120(%rsp)
               	movq	%r14, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	movups	%xmm0, 0x180(%rsp)
               	leaq	0x180(%rsp), %rdx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	leaq	0x1b0(%rsp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	psrlw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	0x1b0(%rsp), %xmm0
               	leaq	0x150(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r15, 0x150(%rsp)
               	movq	-0x58(%rbp), %r10
               	movq	%r10, 0x158(%rsp)
               	movups	0x150(%rsp), %xmm1
               	movups	%xmm1, 0x180(%rsp)
               	leaq	0x180(%rsp), %rdx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	leaq	0x1b0(%rsp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	psrlw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	0x1b0(%rsp), %xmm1
               	movups	%xmm0, 0x160(%rsp)
               	movups	%xmm1, 0x170(%rsp)
               	movq	0x160(%rsp), %rdx
               	movq	0x168(%rsp), %rsi
               	movq	0x170(%rsp), %rdi
               	movq	0x178(%rsp), %r8
               	leaq	(%rsp), %rcx
               	addq	$0x60, %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdi, 0x10(%rcx)
               	movq	%r8, 0x18(%rcx)
               	leaq	0x120(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r13, 0x120(%rsp)
               	movq	%r14, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	movups	%xmm0, 0x130(%rsp)
               	leaq	0x130(%rsp), %rdx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movslq	%ecx, %rcx
               	leaq	0x1c0(%rsp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	psrld	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	0x1c0(%rsp), %xmm0
               	leaq	0x150(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r15, 0x150(%rsp)
               	movq	-0x58(%rbp), %r10
               	movq	%r10, 0x158(%rsp)
               	movups	0x150(%rsp), %xmm1
               	movups	%xmm1, 0x130(%rsp)
               	leaq	0x130(%rsp), %rdx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movslq	%ecx, %rcx
               	leaq	0x1c0(%rsp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	psrld	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	0x1c0(%rsp), %xmm1
               	movups	%xmm0, 0x160(%rsp)
               	movups	%xmm1, 0x170(%rsp)
               	movq	0x160(%rsp), %rdx
               	movq	0x168(%rsp), %rsi
               	movq	0x170(%rsp), %rdi
               	movq	0x178(%rsp), %r8
               	leaq	(%rsp), %rcx
               	addq	$0x80, %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdi, 0x10(%rcx)
               	movq	%r8, 0x18(%rcx)
               	leaq	0x120(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r13, 0x120(%rsp)
               	movq	%r14, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	movups	%xmm0, 0x180(%rsp)
               	leaq	0x180(%rsp), %rdx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movslq	%ecx, %rcx
               	leaq	0x1d0(%rsp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	psrlq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	0x1d0(%rsp), %xmm0
               	leaq	0x150(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r15, 0x150(%rsp)
               	movq	-0x58(%rbp), %r10
               	movq	%r10, 0x158(%rsp)
               	movups	0x150(%rsp), %xmm1
               	movups	%xmm1, 0x180(%rsp)
               	leaq	0x180(%rsp), %rdx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movslq	%ecx, %rcx
               	leaq	0x1d0(%rsp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	psrlq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	0x1d0(%rsp), %xmm1
               	movups	%xmm0, 0x160(%rsp)
               	movups	%xmm1, 0x170(%rsp)
               	movq	0x160(%rsp), %rdx
               	movq	0x168(%rsp), %rsi
               	movq	0x170(%rsp), %rdi
               	movq	0x178(%rsp), %r8
               	leaq	(%rsp), %rcx
               	addq	$0xa0, %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdi, 0x10(%rcx)
               	movq	%r8, 0x18(%rcx)
               	leaq	0x120(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r13, 0x120(%rsp)
               	movq	%r14, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	movups	%xmm0, 0x130(%rsp)
               	leaq	0x130(%rsp), %rdx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movslq	%ecx, %rcx
               	leaq	0x1e0(%rsp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	psraw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	0x1e0(%rsp), %xmm0
               	leaq	0x150(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r15, 0x150(%rsp)
               	movq	-0x58(%rbp), %r10
               	movq	%r10, 0x158(%rsp)
               	movups	0x150(%rsp), %xmm1
               	movups	%xmm1, 0x130(%rsp)
               	leaq	0x130(%rsp), %rdx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movslq	%ecx, %rcx
               	leaq	0x1e0(%rsp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	psraw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	0x1e0(%rsp), %xmm1
               	movups	%xmm0, 0x160(%rsp)
               	movups	%xmm1, 0x170(%rsp)
               	movq	0x160(%rsp), %rdx
               	movq	0x168(%rsp), %rsi
               	movq	0x170(%rsp), %rdi
               	movq	0x178(%rsp), %r8
               	leaq	(%rsp), %rcx
               	addq	$0xc0, %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdi, 0x10(%rcx)
               	movq	%r8, 0x18(%rcx)
               	leaq	0x120(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r13, 0x120(%rsp)
               	movq	%r14, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	movups	%xmm0, 0x180(%rsp)
               	leaq	0x180(%rsp), %rdx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movslq	%ecx, %rcx
               	leaq	0x1f0(%rsp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	psrad	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	0x1f0(%rsp), %xmm0
               	leaq	0x150(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r15, 0x150(%rsp)
               	movq	-0x58(%rbp), %r10
               	movq	%r10, 0x158(%rsp)
               	movups	0x150(%rsp), %xmm1
               	movups	%xmm1, 0x180(%rsp)
               	leaq	0x180(%rsp), %rcx
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %eax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rax
               	leaq	0x1f0(%rsp), %rdx
               	movdqu	(%rcx), %xmm15
               	movq	%rax, %xmm14
               	psrad	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	0x1f0(%rsp), %xmm1
               	movups	%xmm0, 0x160(%rsp)
               	movups	%xmm1, 0x170(%rsp)
               	movq	0x160(%rsp), %rcx
               	movq	0x168(%rsp), %rdx
               	movq	0x170(%rsp), %rsi
               	movq	0x178(%rsp), %rdi
               	leaq	(%rsp), %rax
               	addq	$0xe0, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movl	$0x20, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	leaq	-0x40(%rbp), %r9
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x100(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x60(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x60(%rbp)
               	movl	$0x20, %esi
               	movl	$0x4, %edx
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	leaq	-0x40(%rbp), %r9
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x20, %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x100(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x60(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x60(%rbp)
               	movl	$0x20, %esi
               	movl	$0x8, %edx
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	leaq	-0x40(%rbp), %r9
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x40, %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x100(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x60(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x60(%rbp)
               	movl	$0x20, %esi
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	leaq	-0x40(%rbp), %r9
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x60, %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x100(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x60(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x60(%rbp)
               	movl	$0x20, %esi
               	movl	$0x4, %edx
               	movl	$0x1, %ecx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	leaq	-0x40(%rbp), %r9
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x80, %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x100(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x60(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x60(%rbp)
               	movl	$0x20, %esi
               	movl	$0x8, %edx
               	movl	$0x1, %ecx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	leaq	-0x40(%rbp), %r9
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	addq	$0xa0, %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x100(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x60(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x60(%rbp)
               	movl	$0x20, %esi
               	movl	$0x2, %edx
               	movl	$0x2, %ecx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	leaq	-0x40(%rbp), %r9
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	addq	$0xc0, %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x100(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x60(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x60(%rbp)
               	movl	$0x20, %esi
               	movl	$0x4, %edx
               	movl	$0x2, %ecx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	leaq	-0x40(%rbp), %r9
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	addq	$0xe0, %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x100(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x60(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x60(%rbp)
               	incq	%rbx
               	cmpl	$0xc, %ebx
               	jb	<addr>
               	movq	-0x60(%rbp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<check_variable_shifts>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x120, %rsp            # imm = 0x120
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	leaq	-0x60(%rbp), %r12
               	callq	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	shrq	$0x8, %rax
               	movl	%eax, %ecx
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r12,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %r12
               	callq	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	shrq	$0x8, %rax
               	movl	%eax, %ecx
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r12,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %r12
               	callq	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	shrq	$0x8, %rax
               	movl	%eax, %ecx
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r12,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %r12
               	callq	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	shrq	$0x8, %rax
               	movl	%eax, %ecx
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r12,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %r12
               	callq	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	shrq	$0x8, %rax
               	movl	%eax, %ecx
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r12,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %r12
               	callq	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	shrq	$0x8, %rax
               	movl	%eax, %ecx
               	xorl	%eax, %eax
               	leaq	0x14(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r12,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %r12
               	callq	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	shrq	$0x8, %rax
               	movl	%eax, %ecx
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r12,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %r12
               	callq	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	shrq	$0x8, %rax
               	movl	%eax, %ecx
               	xorl	%eax, %eax
               	leaq	0x1c(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r12,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %r12
               	callq	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r12,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %r12
               	callq	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r12,%rdx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %r12
               	callq	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r12,%rdx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %r12
               	callq	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r12,%rdx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rbx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x80(%rsp), %rax
               	leaq	-0x60(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x80(%rsp), %rax
               	leaq	-0x40(%rbp), %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x100(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x20(%rsp), %rdx
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	xorl	%eax, %eax
               	leaq	0x80(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	cmpl	$0x20, %ecx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	leaq	0x80(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, %esi
               	shlxq	%rsi, %rcx, %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	0xc0(%rsp), %rax
               	movq	0xc8(%rsp), %rcx
               	movq	0xd0(%rsp), %rdx
               	movq	0xd8(%rsp), %rsi
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rsi, 0x78(%rsp)
               	leaq	-0x20(%rbp), %rsi
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	movzbq	(%rbx,%rax), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	leaq	-0x60(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rdi,%rax), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	cmpq	$0x20, %rcx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x4(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	leaq	-0x60(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	cmpq	$0x20, %rcx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x8(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	leaq	-0x60(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	cmpq	$0x20, %rcx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0xc(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	leaq	-0x60(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	cmpq	$0x20, %rcx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x10(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	leaq	-0x60(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	cmpq	$0x20, %rcx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x14(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	leaq	-0x60(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x14(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	cmpq	$0x20, %rcx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	0x14(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x18(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	leaq	-0x60(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x18(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	cmpq	$0x20, %rcx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x1c(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	leaq	-0x60(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x1c(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	cmpq	$0x20, %rcx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	0x1c(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %r13d
               	leaq	(%rsp), %rcx
               	leaq	0x20(%rsp), %rdx
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	xorl	%eax, %eax
               	leaq	0x80(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	cmpl	$0x20, %ecx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movl	%ecx, %ecx
               	leaq	0x80(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, %esi
               	shrxq	%rsi, %rcx, %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	0xc0(%rsp), %rax
               	movq	0xc8(%rsp), %rcx
               	movq	0xd0(%rsp), %rdx
               	movq	0xd8(%rsp), %rsi
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rsi, 0x78(%rsp)
               	leaq	-0x20(%rbp), %rsi
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	movzbq	(%rbx,%rax), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	leaq	-0x60(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rdi,%rax), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	cmpq	$0x20, %rcx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%r12d, %r12d
               	movl	$0x3, %eax
               	shlq	$0x8, %r12
               	leaq	0x4(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %r12
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movq	%rsi, %rdx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x5, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x6, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x7, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	callq	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %r13d
               	leaq	(%rsp), %rcx
               	leaq	0x20(%rsp), %rdx
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	xorl	%eax, %eax
               	leaq	0xc0(%rsp), %rcx
               	movslq	(%rcx,%rax,4), %rsi
               	leaq	0x80(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	cmpl	$0x20, %ecx
               	jb	<addr>
               	movl	$0x1f, %ecx
               	jmp	<addr>
               	leaq	0x80(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movl	%ecx, %ecx
               	sarxq	%rcx, %rsi, %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	0xc0(%rsp), %rax
               	movq	0xc8(%rsp), %rcx
               	movq	0xd0(%rsp), %rdx
               	movq	0xd8(%rsp), %rsi
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rsi, 0x78(%rsp)
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	movl	$0x1, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x1, %ecx
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movq	%rsi, %rdx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	movl	$0x1, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x5, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	movl	$0x1, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x6, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	movl	$0x1, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x7, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	callq	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %r13d
               	leaq	(%rsp), %rcx
               	leaq	0x40(%rsp), %rdx
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	xorl	%eax, %eax
               	leaq	0x80(%rsp), %rcx
               	movq	(%rcx,%rax,8), %rcx
               	cmpq	$0x40, %rcx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rcx
               	movq	(%rcx,%rax,8), %rcx
               	leaq	0x80(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movq	%rcx, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	0xc0(%rsp), %rax
               	movq	0xc8(%rsp), %rcx
               	movq	0xd0(%rsp), %rdx
               	movq	0xd8(%rsp), %rsi
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rsi, 0x78(%rsp)
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	movq	%rbx, %rdi
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x8, %esi
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %rdi
               	xorl	%edx, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x8, %esi
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x1, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	movl	$0x8, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x8, %esi
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x2, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	movl	$0x8, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x8, %esi
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x3, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %r13d
               	leaq	(%rsp), %rcx
               	leaq	0x40(%rsp), %rdx
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	xorl	%eax, %eax
               	leaq	0x80(%rsp), %rcx
               	movq	(%rcx,%rax,8), %rcx
               	cmpq	$0x40, %rcx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rcx
               	movq	(%rcx,%rax,8), %rcx
               	leaq	0x80(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	shrxq	%rsi, %rcx, %rcx
               	movq	%rcx, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	0xc0(%rsp), %rax
               	movq	0xc8(%rsp), %rcx
               	movq	0xd0(%rsp), %rdx
               	movq	0xd8(%rsp), %rsi
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rsi, 0x78(%rsp)
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	movq	%rbx, %rdi
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x8, %esi
               	leaq	-0x40(%rbp), %rdi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x8, %esi
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	movl	$0x8, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x8, %esi
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	movl	$0x8, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x8, %esi
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %r13d
               	leaq	0xe0(%rsp), %rcx
               	leaq	0xf0(%rsp), %rdx
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0x80(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	cmpl	$0x20, %ecx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	leaq	0x80(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, %esi
               	shlxq	%rsi, %rcx, %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	movq	%rbx, %rdi
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	xorl	%ecx, %ecx
               	leaq	-0x60(%rbp), %rdi
               	xorl	%edx, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	xorl	%ecx, %ecx
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x1, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	xorl	%ecx, %ecx
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x2, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	xorl	%ecx, %ecx
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x3, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %r13d
               	leaq	0xe0(%rsp), %rcx
               	leaq	0xf0(%rsp), %rdx
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0x80(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	cmpl	$0x20, %ecx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movl	%ecx, %ecx
               	leaq	0x80(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, %esi
               	shrxq	%rsi, %rcx, %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	movq	%rbx, %rdi
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %r13d
               	leaq	0xe0(%rsp), %rcx
               	leaq	0xf0(%rsp), %rdx
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0xc0(%rsp), %rcx
               	movslq	(%rcx,%rax,4), %rsi
               	leaq	0x80(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	cmpl	$0x20, %ecx
               	jb	<addr>
               	movl	$0x1f, %ecx
               	jmp	<addr>
               	leaq	0x80(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movl	%ecx, %ecx
               	sarxq	%rcx, %rsi, %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	movl	$0x1, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %r13d
               	leaq	0xe0(%rsp), %rcx
               	leaq	0x100(%rsp), %rdx
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0x80(%rsp), %rcx
               	movq	(%rcx,%rax,8), %rcx
               	cmpq	$0x40, %rcx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rcx
               	movq	(%rcx,%rax,8), %rcx
               	leaq	0x80(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movq	%rcx, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	movq	%rbx, %rdi
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x8, %esi
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %rdi
               	xorl	%edx, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x8, %esi
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x1, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %r13d
               	leaq	0xe0(%rsp), %rcx
               	leaq	0x100(%rsp), %rdx
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0x80(%rsp), %rcx
               	movq	(%rcx,%rax,8), %rcx
               	cmpq	$0x40, %rcx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rcx
               	movq	(%rcx,%rax,8), %rcx
               	leaq	0x80(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	shrxq	%rsi, %rcx, %rcx
               	movq	%rcx, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	movq	%rbx, %rdi
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x8, %esi
               	leaq	-0x40(%rbp), %rdi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x8, %esi
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %r13d
               	movq	%r13, %rax
               	leaq	-0x80(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	shrxq	%rcx, %rax, %rcx
               	jmp	<addr>
               	xorl	%r13d, %r13d
               	jmp	<addr>
               	shlxq	%rcx, %rax, %rcx
               	jmp	<addr>
               	shlxq	%rcx, %rax, %rcx
               	jmp	<addr>
               	shlxq	%rcx, %rax, %rcx
               	jmp	<addr>
               	shlxq	%rcx, %rax, %rcx
               	jmp	<addr>
               	shlxq	%rcx, %rax, %rcx
               	jmp	<addr>
               	shlxq	%rcx, %rax, %rcx
               	jmp	<addr>
               	shlxq	%rcx, %rax, %rcx
               	jmp	<addr>
               	shlxq	%rcx, %rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	jmp	<addr>

<check_shuffles>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x238, %rsp            # imm = 0x238
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xaa0, %rsp            # imm = 0xAA0
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	0x180(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rbx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x180(%rsp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r12), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	0x180(%rsp), %r10
               	movq	%r10, -0x208(%rbp)
               	movq	0x188(%rsp), %r10
               	movq	%r10, -0x210(%rbp)
               	movq	0x190(%rsp), %r10
               	movq	%r10, -0x218(%rbp)
               	movq	0x198(%rsp), %r10
               	movq	%r10, -0x220(%rbp)
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x1c(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x18(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x14(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x14(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x1c(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xa80(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x1c0(%rsp)
               	leaq	0x1c0(%rsp), %rax
               	leaq	0x1d0(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufd	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[3,2,1,0]
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x1e0(%rsp)
               	leaq	0x1e0(%rsp), %rax
               	leaq	0x1f0(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufd	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[3,2,1,0]
               	movdqu	%xmm15, (%rcx)
               	movq	0x1d0(%rsp), %rsi
               	movq	0x1d8(%rsp), %rax
               	movq	0x1f0(%rsp), %rcx
               	movq	0x1f8(%rsp), %rdx
               	leaq	0x1a0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x1a0(%rsp)
               	movq	%rax, 0x1a8(%rsp)
               	movq	%rcx, 0x1b0(%rsp)
               	movq	%rdx, 0x1b8(%rsp)
               	movq	0x1a0(%rsp), %rdi
               	leaq	-0x1f8(%rbp), %rsi
               	movq	%rdi, 0x180(%rsp)
               	movq	%rax, 0x188(%rsp)
               	movq	%rcx, 0x190(%rsp)
               	movq	%rdx, 0x198(%rsp)
               	leaq	-0x1d8(%rbp), %rax
               	leaq	0x180(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x1d8(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%r13b
               	movzbq	%r13b, %r13
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	andq	$0x8, %rcx
               	movq	%rdx, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rdx, %rsi
               	leaq	-0x1f8(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rbx,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	addq	$0x4, %rcx
               	movl	$0x1b, %esi
               	subq	$0x4, %rax
               	shlq	%rax
               	sarxq	%rax, %rsi, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rsi
               	jmp	<addr>
               	incq	%rdx
               	cmpl	$0x10, %edx
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xa80(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x200(%rsp)
               	leaq	0x200(%rsp), %rax
               	leaq	0x210(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufhw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,7,6,5,4]
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	leaq	0x230(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufhw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,7,6,5,4]
               	movdqu	%xmm15, (%rcx)
               	movq	0x210(%rsp), %rsi
               	movq	0x218(%rsp), %rax
               	movq	0x230(%rsp), %rcx
               	movq	0x238(%rsp), %rdx
               	leaq	0x1a0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x1a0(%rsp)
               	movq	%rax, 0x1a8(%rsp)
               	movq	%rcx, 0x1b0(%rsp)
               	movq	%rdx, 0x1b8(%rsp)
               	movq	0x1a0(%rsp), %rdi
               	leaq	-0x1f8(%rbp), %rsi
               	movq	%rdi, 0x180(%rsp)
               	movq	%rax, 0x188(%rsp)
               	movq	%rcx, 0x190(%rsp)
               	movq	%rdx, 0x198(%rsp)
               	leaq	-0x1d8(%rbp), %rax
               	leaq	0x180(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x1d8(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	andq	$0x8, %rcx
               	movq	%rdx, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rdx, %rsi
               	leaq	-0x1f8(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rbx,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x1b, %esi
               	shlq	%rax
               	sarxq	%rax, %rsi, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rsi
               	jmp	<addr>
               	incq	%rdx
               	cmpl	$0x10, %edx
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xa80(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x240(%rsp), %rax
               	leaq	0x250(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshuflw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[3,2,1,0,4,5,6,7]
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x260(%rsp)
               	leaq	0x260(%rsp), %rax
               	leaq	0x270(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshuflw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[3,2,1,0,4,5,6,7]
               	movdqu	%xmm15, (%rcx)
               	movq	0x250(%rsp), %rsi
               	movq	0x258(%rsp), %rax
               	movq	0x270(%rsp), %rcx
               	movq	0x278(%rsp), %rdx
               	leaq	0x1a0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x1a0(%rsp)
               	movq	%rax, 0x1a8(%rsp)
               	movq	%rcx, 0x1b0(%rsp)
               	movq	%rdx, 0x1b8(%rsp)
               	movq	0x1a0(%rsp), %rdi
               	leaq	-0x1f8(%rbp), %rsi
               	movq	%rdi, 0x180(%rsp)
               	movq	%rax, 0x188(%rsp)
               	movq	%rcx, 0x190(%rsp)
               	movq	%rdx, 0x198(%rsp)
               	leaq	-0x1d8(%rbp), %rax
               	leaq	0x180(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x1d8(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x14(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x1c(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	leaq	0xa80(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x280(%rsp)
               	leaq	0x280(%rsp), %rax
               	leaq	0x290(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufd	$0x0, %xmm14, %xmm15    # xmm15 = xmm14[0,0,0,0]
               	movdqu	%xmm15, (%rcx)
               	movq	0x30(%rsp), %rax
               	movq	0x38(%rsp), %rcx
               	leaq	0xa90(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0xa90(%rsp)
               	movq	%rcx, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x2a0(%rsp)
               	leaq	0x2a0(%rsp), %rax
               	leaq	0x2b0(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufd	$0x0, %xmm14, %xmm15    # xmm15 = xmm14[0,0,0,0]
               	movdqu	%xmm15, (%rcx)
               	movq	0x290(%rsp), %rsi
               	movq	0x298(%rsp), %rax
               	movq	0x2b0(%rsp), %rcx
               	movq	0x2b8(%rsp), %rdx
               	leaq	0x1a0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x1a0(%rsp)
               	movq	%rax, 0x1a8(%rsp)
               	movq	%rcx, 0x1b0(%rsp)
               	movq	%rdx, 0x1b8(%rsp)
               	movq	0x1a0(%rsp), %rdi
               	leaq	-0x1f8(%rbp), %rsi
               	movq	%rdi, 0x180(%rsp)
               	movq	%rax, 0x188(%rsp)
               	movq	%rcx, 0x190(%rsp)
               	movq	%rdx, 0x198(%rsp)
               	leaq	-0x1d8(%rbp), %rax
               	leaq	0x180(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x1d8(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	andq	$0x8, %rcx
               	movq	%rdx, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rdx, %rsi
               	leaq	-0x1f8(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rbx,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	addq	$0x4, %rcx
               	xorl	%esi, %esi
               	subq	$0x4, %rax
               	shlq	%rax
               	sarxq	%rax, %rsi, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rsi
               	jmp	<addr>
               	incq	%rdx
               	cmpl	$0x10, %edx
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xa80(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x2c0(%rsp)
               	leaq	0x2c0(%rsp), %rax
               	leaq	0x2d0(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufhw	$0x0, %xmm14, %xmm15    # xmm15 = xmm14[0,1,2,3,4,4,4,4]
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x2e0(%rsp)
               	leaq	0x2e0(%rsp), %rax
               	leaq	0x2f0(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufhw	$0x0, %xmm14, %xmm15    # xmm15 = xmm14[0,1,2,3,4,4,4,4]
               	movdqu	%xmm15, (%rcx)
               	movq	0x2d0(%rsp), %rsi
               	movq	0x2d8(%rsp), %rax
               	movq	0x2f0(%rsp), %rcx
               	movq	0x2f8(%rsp), %rdx
               	leaq	0x1a0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x1a0(%rsp)
               	movq	%rax, 0x1a8(%rsp)
               	movq	%rcx, 0x1b0(%rsp)
               	movq	%rdx, 0x1b8(%rsp)
               	movq	0x1a0(%rsp), %rdi
               	leaq	-0x1f8(%rbp), %rsi
               	movq	%rdi, 0x180(%rsp)
               	movq	%rax, 0x188(%rsp)
               	movq	%rcx, 0x190(%rsp)
               	movq	%rdx, 0x198(%rsp)
               	leaq	-0x1d8(%rbp), %rax
               	leaq	0x180(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x1d8(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	andq	$0x8, %rcx
               	movq	%rdx, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rdx, %rsi
               	leaq	-0x1f8(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rbx,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	xorl	%esi, %esi
               	shlq	%rax
               	sarxq	%rax, %rsi, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rsi
               	jmp	<addr>
               	incq	%rdx
               	cmpl	$0x10, %edx
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xa80(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x300(%rsp)
               	leaq	0x300(%rsp), %rax
               	leaq	0x310(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshuflw	$0x0, %xmm14, %xmm15    # xmm15 = xmm14[0,0,0,0,4,5,6,7]
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x320(%rsp)
               	leaq	0x320(%rsp), %rax
               	leaq	0x330(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshuflw	$0x0, %xmm14, %xmm15    # xmm15 = xmm14[0,0,0,0,4,5,6,7]
               	movdqu	%xmm15, (%rcx)
               	movq	0x310(%rsp), %rsi
               	movq	0x318(%rsp), %rax
               	movq	0x330(%rsp), %rcx
               	movq	0x338(%rsp), %rdx
               	leaq	0x1a0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x1a0(%rsp)
               	movq	%rax, 0x1a8(%rsp)
               	movq	%rcx, 0x1b0(%rsp)
               	movq	%rdx, 0x1b8(%rsp)
               	movq	0x1a0(%rsp), %rdi
               	leaq	-0x1f8(%rbp), %rsi
               	movq	%rdi, 0x180(%rsp)
               	movq	%rax, 0x188(%rsp)
               	movq	%rcx, 0x190(%rsp)
               	movq	%rdx, 0x198(%rsp)
               	leaq	-0x1d8(%rbp), %rax
               	leaq	0x180(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x1d8(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x14(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x14(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x18(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x1c(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x1c(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	leaq	0xa80(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x340(%rsp)
               	leaq	0x340(%rsp), %rax
               	leaq	0x350(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xe4, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3]
               	movdqu	%xmm15, (%rcx)
               	movq	0x50(%rsp), %rax
               	movq	0x58(%rsp), %rcx
               	leaq	0xa90(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0xa90(%rsp)
               	movq	%rcx, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x360(%rsp)
               	leaq	0x360(%rsp), %rax
               	leaq	0x370(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xe4, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3]
               	movdqu	%xmm15, (%rcx)
               	movq	0x350(%rsp), %rsi
               	movq	0x358(%rsp), %rax
               	movq	0x370(%rsp), %rcx
               	movq	0x378(%rsp), %rdx
               	leaq	0x1a0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x1a0(%rsp)
               	movq	%rax, 0x1a8(%rsp)
               	movq	%rcx, 0x1b0(%rsp)
               	movq	%rdx, 0x1b8(%rsp)
               	movq	0x1a0(%rsp), %rdi
               	leaq	-0x1f8(%rbp), %rsi
               	movq	%rdi, 0x180(%rsp)
               	movq	%rax, 0x188(%rsp)
               	movq	%rcx, 0x190(%rsp)
               	movq	%rdx, 0x198(%rsp)
               	leaq	-0x1d8(%rbp), %rax
               	leaq	0x180(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x1d8(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	andq	$0x8, %rcx
               	movq	%rdx, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rdx, %rsi
               	leaq	-0x1f8(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rbx,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	addq	$0x4, %rcx
               	movl	$0xe4, %esi
               	subq	$0x4, %rax
               	shlq	%rax
               	sarxq	%rax, %rsi, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rsi
               	jmp	<addr>
               	incq	%rdx
               	cmpl	$0x10, %edx
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xa80(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x380(%rsp)
               	leaq	0x380(%rsp), %rax
               	leaq	0x390(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufhw	$0xe4, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,4,5,6,7]
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x3a0(%rsp)
               	leaq	0x3a0(%rsp), %rax
               	leaq	0x3b0(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufhw	$0xe4, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,4,5,6,7]
               	movdqu	%xmm15, (%rcx)
               	movq	0x390(%rsp), %rsi
               	movq	0x398(%rsp), %rax
               	movq	0x3b0(%rsp), %rcx
               	movq	0x3b8(%rsp), %rdx
               	leaq	0x1a0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x1a0(%rsp)
               	movq	%rax, 0x1a8(%rsp)
               	movq	%rcx, 0x1b0(%rsp)
               	movq	%rdx, 0x1b8(%rsp)
               	movq	0x1a0(%rsp), %rdi
               	leaq	-0x1f8(%rbp), %rsi
               	movq	%rdi, 0x180(%rsp)
               	movq	%rax, 0x188(%rsp)
               	movq	%rcx, 0x190(%rsp)
               	movq	%rdx, 0x198(%rsp)
               	leaq	-0x1d8(%rbp), %rax
               	leaq	0x180(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x1d8(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	andq	$0x8, %rcx
               	movq	%rdx, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rdx, %rsi
               	leaq	-0x1f8(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rbx,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	movl	$0xe4, %esi
               	shlq	%rax
               	sarxq	%rax, %rsi, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rsi
               	jmp	<addr>
               	incq	%rdx
               	cmpl	$0x10, %edx
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xa80(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x3c0(%rsp)
               	leaq	0x3c0(%rsp), %rax
               	leaq	0x3d0(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshuflw	$0xe4, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,4,5,6,7]
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x3e0(%rsp)
               	leaq	0x3e0(%rsp), %rax
               	leaq	0x3f0(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshuflw	$0xe4, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,4,5,6,7]
               	movdqu	%xmm15, (%rcx)
               	movq	0x3d0(%rsp), %rsi
               	movq	0x3d8(%rsp), %rax
               	movq	0x3f0(%rsp), %rcx
               	movq	0x3f8(%rsp), %rdx
               	leaq	0x1a0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x1a0(%rsp)
               	movq	%rax, 0x1a8(%rsp)
               	movq	%rcx, 0x1b0(%rsp)
               	movq	%rdx, 0x1b8(%rsp)
               	movq	0x1a0(%rsp), %rdi
               	leaq	-0x1f8(%rbp), %rsi
               	movq	%rdi, 0x180(%rsp)
               	movq	%rax, 0x188(%rsp)
               	movq	%rcx, 0x190(%rsp)
               	movq	%rdx, 0x198(%rsp)
               	leaq	-0x1d8(%rbp), %rax
               	leaq	0x180(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x1d8(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x1c(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x14(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x14(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x1f8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x18(%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x1c(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x60(%rsp), %rax
               	movq	0x68(%rsp), %rcx
               	leaq	0xa80(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x400(%rsp)
               	leaq	0x400(%rsp), %rax
               	leaq	0x410(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufd	$0x93, %xmm14, %xmm15   # xmm15 = xmm14[3,0,1,2]
               	movdqu	%xmm15, (%rcx)
               	movq	0x70(%rsp), %rax
               	movq	0x78(%rsp), %rcx
               	leaq	0xa90(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0xa90(%rsp)
               	movq	%rcx, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x420(%rsp)
               	leaq	0x420(%rsp), %rax
               	leaq	0x430(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufd	$0x93, %xmm14, %xmm15   # xmm15 = xmm14[3,0,1,2]
               	movdqu	%xmm15, (%rcx)
               	movq	0x410(%rsp), %rsi
               	movq	0x418(%rsp), %rax
               	movq	0x430(%rsp), %rcx
               	movq	0x438(%rsp), %rdx
               	leaq	0x1a0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x1a0(%rsp)
               	movq	%rax, 0x1a8(%rsp)
               	movq	%rcx, 0x1b0(%rsp)
               	movq	%rdx, 0x1b8(%rsp)
               	movq	0x1a0(%rsp), %rdi
               	leaq	-0x1f8(%rbp), %rsi
               	movq	%rdi, 0x180(%rsp)
               	movq	%rax, 0x188(%rsp)
               	movq	%rcx, 0x190(%rsp)
               	movq	%rdx, 0x198(%rsp)
               	leaq	-0x1d8(%rbp), %rax
               	leaq	0x180(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x1d8(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	andq	$0x8, %rcx
               	movq	%rdx, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rdx, %rsi
               	leaq	-0x1f8(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rbx,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	addq	$0x4, %rcx
               	movl	$0x93, %esi
               	subq	$0x4, %rax
               	shlq	%rax
               	sarxq	%rax, %rsi, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rsi
               	jmp	<addr>
               	incq	%rdx
               	cmpl	$0x10, %edx
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xa80(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x440(%rsp)
               	leaq	0x440(%rsp), %rax
               	leaq	0x450(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufhw	$0x93, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,7,4,5,6]
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x460(%rsp)
               	leaq	0x460(%rsp), %rax
               	leaq	0x470(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufhw	$0x93, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,7,4,5,6]
               	movdqu	%xmm15, (%rcx)
               	movq	0x450(%rsp), %rsi
               	movq	0x458(%rsp), %rax
               	movq	0x470(%rsp), %rcx
               	movq	0x478(%rsp), %rdx
               	leaq	0x1a0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x1a0(%rsp)
               	movq	%rax, 0x1a8(%rsp)
               	movq	%rcx, 0x1b0(%rsp)
               	movq	%rdx, 0x1b8(%rsp)
               	movq	0x1a0(%rsp), %rdi
               	leaq	-0x1f8(%rbp), %rsi
               	movq	%rdi, 0x180(%rsp)
               	movq	%rax, 0x188(%rsp)
               	movq	%rcx, 0x190(%rsp)
               	movq	%rdx, 0x198(%rsp)
               	leaq	-0x1d8(%rbp), %rax
               	leaq	0x180(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x1d8(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	andq	$0x8, %rcx
               	movq	%rdx, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rdx, %rsi
               	leaq	-0x1f8(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rbx,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x93, %esi
               	shlq	%rax
               	sarxq	%rax, %rsi, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rsi
               	jmp	<addr>
               	incq	%rdx
               	cmpl	$0x10, %edx
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xa80(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x480(%rsp)
               	leaq	0x480(%rsp), %rax
               	leaq	0x490(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshuflw	$0x93, %xmm14, %xmm15   # xmm15 = xmm14[3,0,1,2,4,5,6,7]
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x4a0(%rsp)
               	leaq	0x4a0(%rsp), %rax
               	leaq	0x4b0(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshuflw	$0x93, %xmm14, %xmm15   # xmm15 = xmm14[3,0,1,2,4,5,6,7]
               	movdqu	%xmm15, (%rcx)
               	movq	0x490(%rsp), %rsi
               	movq	0x498(%rsp), %rax
               	movq	0x4b0(%rsp), %rcx
               	movq	0x4b8(%rsp), %rdx
               	leaq	0x1a0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x1a0(%rsp)
               	movq	%rax, 0x1a8(%rsp)
               	movq	%rcx, 0x1b0(%rsp)
               	movq	%rdx, 0x1b8(%rsp)
               	movq	0x1a0(%rsp), %rdi
               	leaq	-0x1f8(%rbp), %rsi
               	movq	%rdi, 0x180(%rsp)
               	movq	%rax, 0x188(%rsp)
               	movq	%rcx, 0x190(%rsp)
               	movq	%rdx, 0x198(%rsp)
               	leaq	-0x1d8(%rbp), %rax
               	leaq	0x180(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x1d8(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x1f8(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x1f8(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x1f8(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x1f8(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x1f8(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x1f8(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x1f8(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x1f8(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x180(%rsp), %rax
               	movq	0x80(%rsp), %rcx
               	movq	0x88(%rsp), %rdx
               	leaq	0xa80(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa80(%rsp)
               	movq	%rdx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x4d0(%rsp), %rdx
               	movdqu	(%rcx), %xmm14
               	pshufd	$0x4e, %xmm14, %xmm15   # xmm15 = xmm14[2,3,0,1]
               	movdqu	%xmm15, (%rdx)
               	movq	0x90(%rsp), %rcx
               	movq	0x98(%rsp), %rdx
               	leaq	0xa90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa90(%rsp)
               	movq	%rdx, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x4e0(%rsp)
               	leaq	0x4e0(%rsp), %rcx
               	leaq	0x4f0(%rsp), %rdx
               	movdqu	(%rcx), %xmm14
               	pshufd	$0x4e, %xmm14, %xmm15   # xmm15 = xmm14[2,3,0,1]
               	movdqu	%xmm15, (%rdx)
               	movq	0x4d0(%rsp), %rcx
               	movq	0x4d8(%rsp), %rdx
               	movq	0x4f0(%rsp), %rsi
               	movq	0x4f8(%rsp), %rdi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rcx, 0x1a0(%rsp)
               	movq	%rdx, 0x1a8(%rsp)
               	movq	%rsi, 0x1b0(%rsp)
               	movq	%rdi, 0x1b8(%rsp)
               	leaq	0x1a0(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%r13, %r10
               	orq	%rax, %r10
               	movq	%r10, -0x228(%rbp)
               	xorl	%r13d, %r13d
               	movq	%r13, %rcx
               	andq	$0x8, %rcx
               	movq	%r13, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%r13, %rdx
               	jmp	<addr>
               	addq	$0x4, %rcx
               	movl	$0x4e, %edx
               	subq	$0x4, %rax
               	shlq	%rax
               	sarxq	%rax, %rdx, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rdx
               	leaq	-0x1f8(%rbp), %r15
               	movl	$0x2, %r14d
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r15, %rdi
               	movq	%r13, %rdx
               	movq	%r14, %rsi
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x10, %r13d
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x180(%rsp), %rdi
               	leaq	0xa80(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x500(%rsp)
               	leaq	0x500(%rsp), %rax
               	leaq	0x510(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufhw	$0x4e, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,6,7,4,5]
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x520(%rsp)
               	leaq	0x520(%rsp), %rax
               	leaq	0x530(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufhw	$0x4e, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,6,7,4,5]
               	movdqu	%xmm15, (%rcx)
               	movq	0x510(%rsp), %rax
               	movq	0x518(%rsp), %rcx
               	movq	0x530(%rsp), %rdx
               	movq	0x538(%rsp), %rsi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rax, 0x1a0(%rsp)
               	movq	%rcx, 0x1a8(%rsp)
               	movq	%rdx, 0x1b0(%rsp)
               	movq	%rsi, 0x1b8(%rsp)
               	leaq	0x1a0(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x228(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x228(%rbp)
               	xorl	%r13d, %r13d
               	movq	%r13, %rcx
               	andq	$0x8, %rcx
               	movq	%r13, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%r13, %rdx
               	jmp	<addr>
               	movl	$0x4e, %edx
               	shlq	%rax
               	sarxq	%rax, %rdx, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rdx
               	leaq	-0x1f8(%rbp), %r15
               	movl	$0x2, %r14d
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r15, %rdi
               	movq	%r13, %rdx
               	movq	%r14, %rsi
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x10, %r13d
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x180(%rsp), %rdi
               	leaq	0xa80(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x540(%rsp)
               	leaq	0x540(%rsp), %rax
               	leaq	0x550(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshuflw	$0x4e, %xmm14, %xmm15   # xmm15 = xmm14[2,3,0,1,4,5,6,7]
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x560(%rsp)
               	leaq	0x560(%rsp), %rax
               	leaq	0x570(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshuflw	$0x4e, %xmm14, %xmm15   # xmm15 = xmm14[2,3,0,1,4,5,6,7]
               	movdqu	%xmm15, (%rcx)
               	movq	0x550(%rsp), %rax
               	movq	0x558(%rsp), %rcx
               	movq	0x570(%rsp), %rdx
               	movq	0x578(%rsp), %rsi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rax, 0x1a0(%rsp)
               	movq	%rcx, 0x1a8(%rsp)
               	movq	%rdx, 0x1b0(%rsp)
               	movq	%rsi, 0x1b8(%rsp)
               	leaq	0x1a0(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x228(%rbp), %r13
               	orq	%rax, %r13
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	-0x1f8(%rbp), %rdx
               	leaq	(%rcx,%rax), %rsi
               	leaq	(%rcx,%rax), %rdi
               	movzbq	(%r12,%rdi), %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x180(%rsp), %rdi
               	leaq	0xa80(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x580(%rsp)
               	leaq	0x580(%rsp), %rax
               	leaq	0xa80(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0x208(%rbp), %r10
               	movq	%r10, 0xa80(%rsp)
               	movq	-0x210(%rbp), %r10
               	movq	%r10, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x590(%rsp)
               	leaq	0x590(%rsp), %rcx
               	leaq	0x5a0(%rsp), %r8
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	palignr	$0x0, %xmm14, %xmm15    # xmm15 = xmm14[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movdqu	%xmm15, (%r8)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x5b0(%rsp)
               	leaq	0x5b0(%rsp), %rax
               	leaq	0xa90(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0x218(%rbp), %r10
               	movq	%r10, 0xa90(%rsp)
               	movq	-0x220(%rbp), %r10
               	movq	%r10, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x5c0(%rsp)
               	leaq	0x5c0(%rsp), %rcx
               	leaq	0x5d0(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	palignr	$0x0, %xmm14, %xmm15    # xmm15 = xmm14[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movdqu	%xmm15, (%rdx)
               	movq	0x5a0(%rsp), %rax
               	movq	0x5a8(%rsp), %rcx
               	movq	0x5d0(%rsp), %rdx
               	movq	0x5d8(%rsp), %rsi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rax, 0x1a0(%rsp)
               	movq	%rcx, 0x1a8(%rsp)
               	movq	%rdx, 0x1b0(%rsp)
               	movq	%rsi, 0x1b8(%rsp)
               	leaq	0x1a0(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	0x1(%rax), %rdx
               	leaq	-0x1f8(%rbp), %rsi
               	leaq	(%rcx,%rax), %rdi
               	cmpl	$0x10, %edx
               	jge	<addr>
               	addq	%rcx, %rdx
               	movzbq	(%r12,%rdx), %rdx
               	jmp	<addr>
               	addq	%rcx, %rdx
               	subq	$0x10, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	movb	%dl, (%rsi,%rdi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x180(%rsp), %rax
               	movq	0xa0(%rsp), %rcx
               	movq	0xa8(%rsp), %rdx
               	leaq	0xa80(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa80(%rsp)
               	movq	%rdx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x5e0(%rsp)
               	leaq	0x5e0(%rsp), %rcx
               	leaq	0xa80(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x208(%rbp), %r10
               	movq	%r10, 0xa80(%rsp)
               	movq	-0x210(%rbp), %r10
               	movq	%r10, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x5f0(%rsp)
               	leaq	0x5f0(%rsp), %rdx
               	leaq	0x600(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	palignr	$0x1, %xmm14, %xmm15    # xmm15 = xmm14[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],xmm15[0]
               	movdqu	%xmm15, (%rsi)
               	movq	0xb0(%rsp), %rcx
               	movq	0xb8(%rsp), %rdx
               	leaq	0xa90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa90(%rsp)
               	movq	%rdx, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x610(%rsp)
               	leaq	0x610(%rsp), %rcx
               	leaq	0xa90(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x218(%rbp), %r10
               	movq	%r10, 0xa90(%rsp)
               	movq	-0x220(%rbp), %r10
               	movq	%r10, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x620(%rsp)
               	leaq	0x620(%rsp), %rdx
               	leaq	0x630(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	palignr	$0x1, %xmm14, %xmm15    # xmm15 = xmm14[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],xmm15[0]
               	movdqu	%xmm15, (%rsi)
               	movq	0x600(%rsp), %rcx
               	movq	0x608(%rsp), %rdx
               	movq	0x630(%rsp), %rsi
               	movq	0x638(%rsp), %rdi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rcx, 0x1a0(%rsp)
               	movq	%rdx, 0x1a8(%rsp)
               	movq	%rsi, 0x1b0(%rsp)
               	movq	%rdi, 0x1b8(%rsp)
               	leaq	0x1a0(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	0x7(%rax), %rdx
               	leaq	-0x1f8(%rbp), %rsi
               	leaq	(%rcx,%rax), %rdi
               	cmpl	$0x10, %edx
               	jge	<addr>
               	addq	%rcx, %rdx
               	movzbq	(%r12,%rdx), %rdx
               	jmp	<addr>
               	addq	%rcx, %rdx
               	subq	$0x10, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	movb	%dl, (%rsi,%rdi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0xc0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x180(%rsp), %rax
               	movq	0xc0(%rsp), %rcx
               	movq	0xc8(%rsp), %rdx
               	leaq	0xa80(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa80(%rsp)
               	movq	%rdx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x640(%rsp)
               	leaq	0x640(%rsp), %rcx
               	leaq	0xa80(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x208(%rbp), %r10
               	movq	%r10, 0xa80(%rsp)
               	movq	-0x210(%rbp), %r10
               	movq	%r10, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x650(%rsp)
               	leaq	0x650(%rsp), %rdx
               	leaq	0x660(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	palignr	$0x7, %xmm14, %xmm15    # xmm15 = xmm14[7,8,9,10,11,12,13,14,15],xmm15[0,1,2,3,4,5,6]
               	movdqu	%xmm15, (%rsi)
               	movq	0xd0(%rsp), %rcx
               	movq	0xd8(%rsp), %rdx
               	leaq	0xa90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa90(%rsp)
               	movq	%rdx, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x670(%rsp)
               	leaq	0x670(%rsp), %rcx
               	leaq	0xa90(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x218(%rbp), %r10
               	movq	%r10, 0xa90(%rsp)
               	movq	-0x220(%rbp), %r10
               	movq	%r10, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x680(%rsp)
               	leaq	0x680(%rsp), %rdx
               	leaq	0x690(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	palignr	$0x7, %xmm14, %xmm15    # xmm15 = xmm14[7,8,9,10,11,12,13,14,15],xmm15[0,1,2,3,4,5,6]
               	movdqu	%xmm15, (%rsi)
               	movq	0x660(%rsp), %rcx
               	movq	0x668(%rsp), %rdx
               	movq	0x690(%rsp), %rsi
               	movq	0x698(%rsp), %rdi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rcx, 0x1a0(%rsp)
               	movq	%rdx, 0x1a8(%rsp)
               	movq	%rsi, 0x1b0(%rsp)
               	movq	%rdi, 0x1b8(%rsp)
               	leaq	0x1a0(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	0xf(%rax), %rdx
               	leaq	-0x1f8(%rbp), %rsi
               	leaq	(%rcx,%rax), %rdi
               	cmpl	$0x10, %edx
               	jge	<addr>
               	addq	%rcx, %rdx
               	movzbq	(%r12,%rdx), %rdx
               	jmp	<addr>
               	addq	%rcx, %rdx
               	subq	$0x10, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	movb	%dl, (%rsi,%rdi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0xe0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x180(%rsp), %rax
               	movq	0xe0(%rsp), %rcx
               	movq	0xe8(%rsp), %rdx
               	leaq	0xa80(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa80(%rsp)
               	movq	%rdx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x6a0(%rsp)
               	leaq	0x6a0(%rsp), %rcx
               	leaq	0xa80(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x208(%rbp), %r10
               	movq	%r10, 0xa80(%rsp)
               	movq	-0x210(%rbp), %r10
               	movq	%r10, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x6b0(%rsp)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x6c0(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	palignr	$0xf, %xmm14, %xmm15    # xmm15 = xmm14[15],xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
               	movdqu	%xmm15, (%rsi)
               	movq	0xf0(%rsp), %rcx
               	movq	0xf8(%rsp), %rdx
               	leaq	0xa90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa90(%rsp)
               	movq	%rdx, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x6d0(%rsp)
               	leaq	0x6d0(%rsp), %rcx
               	leaq	0xa90(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x218(%rbp), %r10
               	movq	%r10, 0xa90(%rsp)
               	movq	-0x220(%rbp), %r10
               	movq	%r10, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x6e0(%rsp)
               	leaq	0x6e0(%rsp), %rdx
               	leaq	0x6f0(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	palignr	$0xf, %xmm14, %xmm15    # xmm15 = xmm14[15],xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
               	movdqu	%xmm15, (%rsi)
               	movq	0x6c0(%rsp), %rcx
               	movq	0x6c8(%rsp), %rdx
               	movq	0x6f0(%rsp), %rsi
               	movq	0x6f8(%rsp), %rdi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rcx, 0x1a0(%rsp)
               	movq	%rdx, 0x1a8(%rsp)
               	movq	%rsi, 0x1b0(%rsp)
               	movq	%rdi, 0x1b8(%rsp)
               	leaq	0x1a0(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%r13, %r12
               	orq	%rax, %r12
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rdx
               	leaq	-0x1f8(%rbp), %rsi
               	leaq	(%rcx,%rax), %rdi
               	addq	%rcx, %rdx
               	subq	$0x10, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	movb	%dl, (%rsi,%rdi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x180(%rsp), %rax
               	movq	0x100(%rsp), %rcx
               	movq	0x108(%rsp), %rdx
               	leaq	0xa80(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa80(%rsp)
               	movq	%rdx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x700(%rsp)
               	leaq	0x700(%rsp), %rcx
               	leaq	0xa80(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x208(%rbp), %r10
               	movq	%r10, 0xa80(%rsp)
               	movq	-0x210(%rbp), %r10
               	movq	%r10, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x710(%rsp)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x720(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	palignr	$0x10, %xmm14, %xmm15   # xmm15 = xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movdqu	%xmm15, (%rsi)
               	movq	0x110(%rsp), %rcx
               	movq	0x118(%rsp), %rdx
               	leaq	0xa90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa90(%rsp)
               	movq	%rdx, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x730(%rsp)
               	leaq	0x730(%rsp), %rcx
               	leaq	0xa90(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x218(%rbp), %r10
               	movq	%r10, 0xa90(%rsp)
               	movq	-0x220(%rbp), %r10
               	movq	%r10, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x740(%rsp)
               	leaq	0x740(%rsp), %rdx
               	leaq	0x750(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	palignr	$0x10, %xmm14, %xmm15   # xmm15 = xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movdqu	%xmm15, (%rsi)
               	movq	0x720(%rsp), %rcx
               	movq	0x728(%rsp), %rdx
               	movq	0x750(%rsp), %rsi
               	movq	0x758(%rsp), %rdi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rcx, 0x1a0(%rsp)
               	movq	%rdx, 0x1a8(%rsp)
               	movq	%rsi, 0x1b0(%rsp)
               	movq	%rdi, 0x1b8(%rsp)
               	leaq	0x1a0(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	0x11(%rax), %rcx
               	leaq	-0x1f8(%rbp), %rsi
               	leaq	(%rdx,%rax), %rdi
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	addq	%rdx, %rcx
               	subq	$0x10, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rsi,%rdi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x120(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x180(%rsp), %rax
               	movq	0x120(%rsp), %rcx
               	movq	0x128(%rsp), %rdx
               	leaq	0xa80(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa80(%rsp)
               	movq	%rdx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x760(%rsp)
               	leaq	0x760(%rsp), %rcx
               	leaq	0xa80(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x208(%rbp), %r10
               	movq	%r10, 0xa80(%rsp)
               	movq	-0x210(%rbp), %r10
               	movq	%r10, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x770(%rsp)
               	leaq	0x770(%rsp), %rdx
               	leaq	0x780(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	palignr	$0x11, %xmm14, %xmm15   # xmm15 = xmm15[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0]
               	movdqu	%xmm15, (%rsi)
               	movq	0x130(%rsp), %rcx
               	movq	0x138(%rsp), %rdx
               	leaq	0xa90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa90(%rsp)
               	movq	%rdx, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x790(%rsp)
               	leaq	0x790(%rsp), %rcx
               	leaq	0xa90(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x218(%rbp), %r10
               	movq	%r10, 0xa90(%rsp)
               	movq	-0x220(%rbp), %r10
               	movq	%r10, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x7a0(%rsp)
               	leaq	0x7a0(%rsp), %rdx
               	leaq	0x7b0(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	palignr	$0x11, %xmm14, %xmm15   # xmm15 = xmm15[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0]
               	movdqu	%xmm15, (%rsi)
               	movq	0x780(%rsp), %rcx
               	movq	0x788(%rsp), %rdx
               	movq	0x7b0(%rsp), %rsi
               	movq	0x7b8(%rsp), %rdi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rcx, 0x1a0(%rsp)
               	movq	%rdx, 0x1a8(%rsp)
               	movq	%rsi, 0x1b0(%rsp)
               	movq	%rdi, 0x1b8(%rsp)
               	leaq	0x1a0(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	0x1f(%rax), %rcx
               	leaq	-0x1f8(%rbp), %rsi
               	leaq	(%rdx,%rax), %rdi
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	addq	%rdx, %rcx
               	subq	$0x10, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rsi,%rdi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x180(%rsp), %rax
               	movq	0x140(%rsp), %rcx
               	movq	0x148(%rsp), %rdx
               	leaq	0xa80(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa80(%rsp)
               	movq	%rdx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x7c0(%rsp)
               	leaq	0x7c0(%rsp), %rcx
               	leaq	0xa80(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x208(%rbp), %r10
               	movq	%r10, 0xa80(%rsp)
               	movq	-0x210(%rbp), %r10
               	movq	%r10, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x7d0(%rsp)
               	leaq	0x7d0(%rsp), %rdx
               	leaq	0x7e0(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	palignr	$0x1f, %xmm14, %xmm15   # xmm15 = xmm15[15,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
               	movdqu	%xmm15, (%rsi)
               	movq	0x150(%rsp), %rcx
               	movq	0x158(%rsp), %rdx
               	leaq	0xa90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa90(%rsp)
               	movq	%rdx, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x7f0(%rsp)
               	leaq	0x7f0(%rsp), %rcx
               	leaq	0xa90(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x218(%rbp), %r10
               	movq	%r10, 0xa90(%rsp)
               	movq	-0x220(%rbp), %r10
               	movq	%r10, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x800(%rsp)
               	leaq	0x800(%rsp), %rdx
               	leaq	0x810(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	palignr	$0x1f, %xmm14, %xmm15   # xmm15 = xmm15[15,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
               	movdqu	%xmm15, (%rsi)
               	movq	0x7e0(%rsp), %rcx
               	movq	0x7e8(%rsp), %rdx
               	movq	0x810(%rsp), %rsi
               	movq	0x818(%rsp), %rdi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rcx, 0x1a0(%rsp)
               	movq	%rdx, 0x1a8(%rsp)
               	movq	%rsi, 0x1b0(%rsp)
               	movq	%rdi, 0x1b8(%rsp)
               	leaq	0x1a0(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	-0x1f8(%rbp), %rdx
               	leaq	(%rcx,%rax), %rsi
               	movb	$0x0, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x160(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x180(%rsp), %rax
               	movq	0x160(%rsp), %rcx
               	movq	0x168(%rsp), %rdx
               	leaq	0xa80(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa80(%rsp)
               	movq	%rdx, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x820(%rsp)
               	leaq	0x820(%rsp), %rcx
               	leaq	0xa80(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x208(%rbp), %r10
               	movq	%r10, 0xa80(%rsp)
               	movq	-0x210(%rbp), %r10
               	movq	%r10, 0xa88(%rsp)
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x830(%rsp)
               	leaq	0x830(%rsp), %rdx
               	leaq	0x840(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	palignr	$0x20, %xmm14, %xmm15   # xmm15 = xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movdqu	%xmm15, (%rsi)
               	movq	0x170(%rsp), %rcx
               	movq	0x178(%rsp), %rdx
               	leaq	0xa90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa90(%rsp)
               	movq	%rdx, 0xa98(%rsp)
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x850(%rsp)
               	leaq	0x850(%rsp), %rcx
               	leaq	0xa90(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x218(%rbp), %r10
               	movq	%r10, 0xa90(%rsp)
               	movq	-0x220(%rbp), %r10
               	movq	%r10, 0xa98(%rsp)
               	leaq	0x860(%rsp), %rdx
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x860(%rsp)
               	leaq	0x870(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	palignr	$0x20, %xmm14, %xmm15   # xmm15 = xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movdqu	%xmm15, (%rsi)
               	movq	0x840(%rsp), %rcx
               	movq	0x848(%rsp), %rdx
               	movq	0x870(%rsp), %rsi
               	movq	0x878(%rsp), %rdi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rcx, 0x1a0(%rsp)
               	movq	%rdx, 0x1a8(%rsp)
               	movq	%rsi, 0x1b0(%rsp)
               	leaq	0x1a0(%rsp), %rcx
               	movq	%rdi, 0x1b8(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	-0x1f8(%rbp), %rsi
               	leaq	(%rdx,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rdi
               	movb	%dil, (%rsi,%rcx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x180(%rsp), %rdi
               	leaq	0xa80(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	leaq	0x880(%rsp), %rax
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x880(%rsp)
               	leaq	0x890(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x0, %xmm15            # xmm15 = xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	leaq	0x8a0(%rsp), %rax
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x8a0(%rsp)
               	leaq	0x8b0(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x0, %xmm15            # xmm15 = xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movdqu	%xmm15, (%rcx)
               	movq	0x890(%rsp), %rax
               	movq	0x898(%rsp), %rcx
               	movq	0x8b0(%rsp), %rdx
               	movq	0x8b8(%rsp), %rsi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rax, 0x1a0(%rsp)
               	movq	%rcx, 0x1a8(%rsp)
               	movq	%rdx, 0x1b0(%rsp)
               	leaq	0x1a0(%rsp), %rax
               	movq	%rsi, 0x1b8(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	-0x1f8(%rbp), %rsi
               	leaq	(%rdx,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rdi
               	movb	%dil, (%rsi,%rcx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x180(%rsp), %rdi
               	leaq	0xa80(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	leaq	0x8c0(%rsp), %rax
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x8c0(%rsp)
               	leaq	0x8d0(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x0, %xmm15            # xmm15 = xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	leaq	0x8e0(%rsp), %rax
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x8e0(%rsp)
               	leaq	0x8f0(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x0, %xmm15            # xmm15 = xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movdqu	%xmm15, (%rcx)
               	movq	0x8d0(%rsp), %rax
               	movq	0x8d8(%rsp), %rcx
               	movq	0x8f0(%rsp), %rdx
               	movq	0x8f8(%rsp), %rsi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rax, 0x1a0(%rsp)
               	movq	%rcx, 0x1a8(%rsp)
               	movq	%rdx, 0x1b0(%rsp)
               	leaq	0x1a0(%rsp), %rax
               	movq	%rsi, 0x1b8(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	leaq	-0x1f8(%rbp), %rdi
               	leaq	(%rsi,%rax), %rdx
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	-0x3(%rdx), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rdx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rsi
               	cmpl	$0x20, %esi
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x180(%rsp), %rdi
               	leaq	0xa80(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	leaq	0x900(%rsp), %rax
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x900(%rsp)
               	leaq	0x910(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x3, %xmm15            # xmm15 = zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12]
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	leaq	0x920(%rsp), %rax
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x920(%rsp)
               	leaq	0x930(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x3, %xmm15            # xmm15 = zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12]
               	movdqu	%xmm15, (%rcx)
               	movq	0x910(%rsp), %rax
               	movq	0x918(%rsp), %rcx
               	movq	0x930(%rsp), %rdx
               	movq	0x938(%rsp), %rsi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rax, 0x1a0(%rsp)
               	movq	%rcx, 0x1a8(%rsp)
               	movq	%rdx, 0x1b0(%rsp)
               	leaq	0x1a0(%rsp), %rax
               	movq	%rsi, 0x1b8(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	leaq	-0x1f8(%rbp), %rdi
               	leaq	(%rsi,%rax), %rdx
               	leaq	0x3(%rax), %rcx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	leaq	0x3(%rdx), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rdx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rsi
               	cmpl	$0x20, %esi
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x180(%rsp), %rdi
               	leaq	0xa80(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	leaq	0x940(%rsp), %rax
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x940(%rsp)
               	leaq	0x950(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x3, %xmm15            # xmm15 = xmm15[3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	leaq	0x960(%rsp), %rax
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x960(%rsp)
               	leaq	0x970(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x3, %xmm15            # xmm15 = xmm15[3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	movq	0x950(%rsp), %rax
               	movq	0x958(%rsp), %rcx
               	movq	0x970(%rsp), %rdx
               	movq	0x978(%rsp), %rsi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rax, 0x1a0(%rsp)
               	movq	%rcx, 0x1a8(%rsp)
               	movq	%rdx, 0x1b0(%rsp)
               	leaq	0x1a0(%rsp), %rax
               	movq	%rsi, 0x1b8(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	leaq	-0x1f8(%rbp), %rdi
               	leaq	(%rsi,%rax), %rdx
               	cmpl	$0xf, %eax
               	jl	<addr>
               	leaq	-0xf(%rdx), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rdx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rsi
               	cmpl	$0x20, %esi
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x180(%rsp), %rdi
               	leaq	0xa80(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	leaq	0x980(%rsp), %rax
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x980(%rsp)
               	leaq	0x990(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0xf, %xmm15            # xmm15 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,xmm15[0]
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	leaq	0x9a0(%rsp), %rax
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x9a0(%rsp)
               	leaq	0x9b0(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0xf, %xmm15            # xmm15 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,xmm15[0]
               	movdqu	%xmm15, (%rcx)
               	movq	0x990(%rsp), %rax
               	movq	0x998(%rsp), %rcx
               	movq	0x9b0(%rsp), %rdx
               	movq	0x9b8(%rsp), %rsi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rax, 0x1a0(%rsp)
               	movq	%rcx, 0x1a8(%rsp)
               	movq	%rdx, 0x1b0(%rsp)
               	leaq	0x1a0(%rsp), %rax
               	movq	%rsi, 0x1b8(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	leaq	-0x1f8(%rbp), %rdi
               	leaq	(%rsi,%rax), %rdx
               	leaq	0xf(%rax), %rcx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	leaq	0xf(%rdx), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rdx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rsi
               	cmpl	$0x20, %esi
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x180(%rsp), %rdi
               	leaq	0xa80(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	leaq	0x9c0(%rsp), %rax
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0x9c0(%rsp)
               	leaq	0x9d0(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0xf, %xmm15            # xmm15 = xmm15[15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	leaq	0x9e0(%rsp), %rax
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0x9e0(%rsp)
               	leaq	0x9f0(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0xf, %xmm15            # xmm15 = xmm15[15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	movq	0x9d0(%rsp), %rax
               	movq	0x9d8(%rsp), %rcx
               	movq	0x9f0(%rsp), %rdx
               	movq	0x9f8(%rsp), %rsi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rax, 0x1a0(%rsp)
               	movq	%rcx, 0x1a8(%rsp)
               	movq	%rdx, 0x1b0(%rsp)
               	movq	%rsi, 0x1b8(%rsp)
               	leaq	0x1a0(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%r12, %rbx
               	orq	%rax, %rbx
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x1f8(%rbp), %rsi
               	leaq	(%rdx,%rax), %rdi
               	movb	%cl, (%rsi,%rdi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x180(%rsp), %rdi
               	leaq	0xa80(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	leaq	0xa00(%rsp), %rax
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0xa00(%rsp)
               	leaq	0xa10(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x10, %xmm15           # xmm15 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	leaq	0xa20(%rsp), %rax
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0xa20(%rsp)
               	leaq	0xa30(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x10, %xmm15           # xmm15 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	movq	0xa10(%rsp), %rax
               	movq	0xa18(%rsp), %rcx
               	movq	0xa30(%rsp), %rdx
               	movq	0xa38(%rsp), %rsi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rax, 0x1a0(%rsp)
               	movq	%rcx, 0x1a8(%rsp)
               	movq	%rdx, 0x1b0(%rsp)
               	movq	%rsi, 0x1b8(%rsp)
               	leaq	0x1a0(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x1f8(%rbp), %rsi
               	leaq	(%rdx,%rax), %rdi
               	movb	%cl, (%rsi,%rdi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x180(%rsp), %rdi
               	leaq	0xa80(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0xa80(%rsp)
               	movq	%rcx, 0xa88(%rsp)
               	leaq	0xa40(%rsp), %rax
               	movups	0xa80(%rsp), %xmm0
               	movups	%xmm0, 0xa40(%rsp)
               	leaq	0xa50(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x10, %xmm15           # xmm15 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	0xa90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa90(%rsp)
               	movq	%rsi, 0xa98(%rsp)
               	leaq	0xa60(%rsp), %rax
               	movups	0xa90(%rsp), %xmm0
               	movups	%xmm0, 0xa60(%rsp)
               	leaq	0xa70(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x10, %xmm15           # xmm15 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	movq	0xa50(%rsp), %rax
               	movq	0xa58(%rsp), %rcx
               	movq	0xa70(%rsp), %rdx
               	movq	0xa78(%rsp), %rsi
               	leaq	0x1a0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rax, 0x1a0(%rsp)
               	movq	%rcx, 0x1a8(%rsp)
               	movq	%rdx, 0x1b0(%rsp)
               	movq	%rsi, 0x1b8(%rsp)
               	leaq	0x1a0(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x180(%rsp), %r9
               	leaq	-0x1f8(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rbx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leaq	-0x260(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<check_blends>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x138, %rsp            # imm = 0x138
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x760, %rsp            # imm = 0x760
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rdx, %r14
               	movq	%rsi, %r12
               	leaq	0x100(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rbx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x100(%rsp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r12), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x140(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x150(%rsp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%r8d, %r8d
               	leaq	-0x108(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movq	%r8, %rax
               	andq	$0x7, %rax
               	sarxq	%rax, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%r8, %r9
               	shlq	%r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rbx, %rsi
               	jmp	<addr>
               	incq	%r8
               	cmpl	$0x10, %r8d
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %r13
               	leaq	0x700(%rsp), %r15
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r15)
               	movq	%rax, 0x700(%rsp)
               	movq	%rcx, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x160(%rsp)
               	leaq	0x160(%rsp), %rcx
               	leaq	0x700(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0x700(%rsp)
               	movq	%r8, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x170(%rsp)
               	leaq	0x170(%rsp), %rdi
               	leaq	0x180(%rsp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdi), %xmm14
               	pblendw	$0x0, %xmm14, %xmm15    # xmm15 = xmm15[0,1,2,3,4,5,6,7]
               	movdqu	%xmm15, (%rax)
               	leaq	0x710(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rdx, 0x710(%rsp)
               	movq	%rsi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x190(%rsp)
               	leaq	0x190(%rsp), %rdx
               	leaq	0x710(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r9, 0x710(%rsp)
               	movq	%r13, 0x718(%rsp)
               	leaq	0x1a0(%rsp), %rsi
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x1a0(%rsp)
               	leaq	0x1b0(%rsp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pblendw	$0x0, %xmm14, %xmm15    # xmm15 = xmm15[0,1,2,3,4,5,6,7]
               	movdqu	%xmm15, (%rcx)
               	leaq	0x720(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x730(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0x720(%rsp), %rax
               	movq	%rax, 0x120(%rsp)
               	movq	0x728(%rsp), %rax
               	movq	%rax, 0x128(%rsp)
               	movq	0x730(%rsp), %rcx
               	movq	%rcx, 0x130(%rsp)
               	movq	0x738(%rsp), %rdx
               	movq	%rdx, 0x138(%rsp)
               	movq	0x120(%rsp), %rdi
               	leaq	-0x108(%rbp), %rsi
               	movq	%rdi, 0x100(%rsp)
               	movq	%rax, 0x108(%rsp)
               	movq	%rcx, 0x110(%rsp)
               	movq	%rdx, 0x118(%rsp)
               	leaq	-0xe8(%rbp), %rdi
               	leaq	0x100(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%r13b
               	movzbq	%r13b, %r13
               	xorl	%r8d, %r8d
               	leaq	-0x108(%rbp), %rdi
               	xorl	%eax, %eax
               	sarxq	%r8, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movq	%r8, %r9
               	shlq	$0x2, %r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rsi
               	shlq	$0x2, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rbx, %rsi
               	jmp	<addr>
               	incq	%r8
               	cmpl	$0x8, %r8d
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x20(%rsp), %rdi
               	leaq	0x40(%rsp), %r8
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x700(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0x700(%rsp)
               	movq	%rcx, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	leaq	0x1c0(%rsp), %rax
               	movups	%xmm0, 0x1c0(%rsp)
               	movq	0x40(%rsp), %rcx
               	movq	0x48(%rsp), %rdi
               	leaq	0x700(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rcx, 0x700(%rsp)
               	movq	%rdi, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x1d0(%rsp)
               	leaq	0x1d0(%rsp), %rcx
               	leaq	0x1e0(%rsp), %rdi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0x0, %xmm14, %xmm15    # xmm15 = xmm15[0,1,2,3]
               	movdqu	%xmm15, (%rdi)
               	movups	0x1e0(%rsp), %xmm0
               	leaq	0x710(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x710(%rsp)
               	movq	%rsi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm1
               	leaq	0x1f0(%rsp), %rax
               	movups	%xmm1, 0x1f0(%rsp)
               	movq	0x50(%rsp), %rcx
               	movq	0x58(%rsp), %rdx
               	leaq	0x710(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0x710(%rsp)
               	movq	%rdx, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm1
               	leaq	0x200(%rsp), %rcx
               	movups	%xmm1, 0x200(%rsp)
               	leaq	0x210(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0x0, %xmm14, %xmm15    # xmm15 = xmm15[0,1,2,3]
               	movdqu	%xmm15, (%rdx)
               	movups	0x210(%rsp), %xmm1
               	movups	%xmm0, 0x720(%rsp)
               	movups	%xmm1, 0x730(%rsp)
               	leaq	0x120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0x720(%rsp), %rax
               	movq	%rax, 0x120(%rsp)
               	movq	0x728(%rsp), %rax
               	movq	%rax, 0x128(%rsp)
               	movq	0x730(%rsp), %rcx
               	movq	%rcx, 0x130(%rsp)
               	movq	0x738(%rsp), %rdx
               	movq	%rdx, 0x138(%rsp)
               	movq	0x120(%rsp), %rdi
               	leaq	-0x108(%rbp), %rsi
               	movq	%rdi, 0x100(%rsp)
               	movq	%rax, 0x108(%rsp)
               	movq	%rcx, 0x110(%rsp)
               	movq	%rdx, 0x118(%rsp)
               	leaq	-0xe8(%rbp), %rdi
               	leaq	0x100(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	leaq	0x220(%rsp), %rax
               	movups	0x140(%rsp), %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x230(%rsp), %rcx
               	movups	0x150(%rsp), %xmm0
               	movups	%xmm0, 0x230(%rsp)
               	leaq	0x240(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0x0, %xmm14, %xmm15    # xmm15 = xmm15[0,1,2,3]
               	movdqu	%xmm15, (%rdx)
               	movups	0x240(%rsp), %xmm0
               	leaq	-0x108(%rbp), %rsi
               	leaq	0x740(%rsp), %rax
               	movups	%xmm0, 0x740(%rsp)
               	leaq	-0x118(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x118(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%r8d, %r8d
               	leaq	-0x108(%rbp), %rdi
               	movl	$0xff, %eax
               	movq	%r8, %rcx
               	andq	$0x7, %rcx
               	sarxq	%rcx, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%r8, %r9
               	shlq	%r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rbx, %rsi
               	jmp	<addr>
               	incq	%r8
               	cmpl	$0x10, %r8d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rsi
               	movq	0x60(%rsp), %rdi
               	movq	0x68(%rsp), %r8
               	leaq	0x700(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movq	%rdi, 0x700(%rsp)
               	movq	%r8, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x250(%rsp)
               	leaq	0x250(%rsp), %rdi
               	leaq	0x700(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0x700(%rsp)
               	movq	%rcx, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x260(%rsp)
               	leaq	0x260(%rsp), %rcx
               	leaq	0x270(%rsp), %rax
               	movdqu	(%rdi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pblendw	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,4,5,6,7]
               	movdqu	%xmm15, (%rax)
               	movq	0x70(%rsp), %rcx
               	movq	0x78(%rsp), %rdi
               	leaq	0x710(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rcx, 0x710(%rsp)
               	movq	%rdi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x280(%rsp)
               	leaq	0x280(%rsp), %rdi
               	leaq	0x710(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rdx, 0x710(%rsp)
               	movq	%rsi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x290(%rsp)
               	leaq	0x290(%rsp), %rdx
               	leaq	0x2a0(%rsp), %rcx
               	movdqu	(%rdi), %xmm15
               	movdqu	(%rdx), %xmm14
               	pblendw	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,4,5,6,7]
               	movdqu	%xmm15, (%rcx)
               	leaq	0x720(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x730(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0x720(%rsp), %rax
               	movq	%rax, 0x120(%rsp)
               	movq	0x728(%rsp), %rax
               	movq	%rax, 0x128(%rsp)
               	movq	0x730(%rsp), %rcx
               	movq	%rcx, 0x130(%rsp)
               	movq	0x738(%rsp), %rdx
               	movq	%rdx, 0x138(%rsp)
               	movq	0x120(%rsp), %rdi
               	leaq	-0x108(%rbp), %rsi
               	movq	%rdi, 0x100(%rsp)
               	movq	%rax, 0x108(%rsp)
               	movq	%rcx, 0x110(%rsp)
               	movq	%rdx, 0x118(%rsp)
               	leaq	-0xe8(%rbp), %rdi
               	leaq	0x100(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%r8d, %r8d
               	leaq	-0x108(%rbp), %rdi
               	movl	$0xff, %eax
               	sarxq	%r8, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movq	%r8, %r9
               	shlq	$0x2, %r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rsi
               	shlq	$0x2, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rbx, %rsi
               	jmp	<addr>
               	incq	%r8
               	cmpl	$0x8, %r8d
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x20(%rsp), %rdi
               	leaq	0x40(%rsp), %r8
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x700(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0x700(%rsp)
               	movq	%rcx, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	leaq	0x2b0(%rsp), %rax
               	movups	%xmm0, 0x2b0(%rsp)
               	movq	0x40(%rsp), %rcx
               	movq	0x48(%rsp), %rdi
               	leaq	0x700(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rcx, 0x700(%rsp)
               	movq	%rdi, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x2c0(%rsp)
               	leaq	0x2c0(%rsp), %rcx
               	leaq	0x2d0(%rsp), %rdi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0xf, %xmm14, %xmm15    # xmm15 = xmm14[0,1,2,3]
               	movdqu	%xmm15, (%rdi)
               	movups	0x2d0(%rsp), %xmm0
               	leaq	0x710(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x710(%rsp)
               	movq	%rsi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm1
               	leaq	0x2e0(%rsp), %rax
               	movups	%xmm1, 0x2e0(%rsp)
               	movq	0x50(%rsp), %rcx
               	movq	0x58(%rsp), %rdx
               	leaq	0x710(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0x710(%rsp)
               	movq	%rdx, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm1
               	leaq	0x2f0(%rsp), %rcx
               	movups	%xmm1, 0x2f0(%rsp)
               	leaq	0x300(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0xf, %xmm14, %xmm15    # xmm15 = xmm14[0,1,2,3]
               	movdqu	%xmm15, (%rdx)
               	movups	0x300(%rsp), %xmm1
               	movups	%xmm0, 0x720(%rsp)
               	movups	%xmm1, 0x730(%rsp)
               	leaq	0x120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0x720(%rsp), %rax
               	movq	%rax, 0x120(%rsp)
               	movq	0x728(%rsp), %rax
               	movq	%rax, 0x128(%rsp)
               	movq	0x730(%rsp), %rcx
               	movq	%rcx, 0x130(%rsp)
               	movq	0x738(%rsp), %rdx
               	movq	%rdx, 0x138(%rsp)
               	movq	0x120(%rsp), %rdi
               	leaq	-0x108(%rbp), %rsi
               	movq	%rdi, 0x100(%rsp)
               	movq	%rax, 0x108(%rsp)
               	movq	%rcx, 0x110(%rsp)
               	movq	%rdx, 0x118(%rsp)
               	leaq	-0xe8(%rbp), %rdi
               	leaq	0x100(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	leaq	0x310(%rsp), %rax
               	movups	0x140(%rsp), %xmm0
               	movups	%xmm0, 0x310(%rsp)
               	leaq	0x320(%rsp), %rcx
               	movups	0x150(%rsp), %xmm0
               	movups	%xmm0, 0x320(%rsp)
               	leaq	0x330(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0xf, %xmm14, %xmm15    # xmm15 = xmm14[0,1,2,3]
               	movdqu	%xmm15, (%rdx)
               	movups	0x330(%rsp), %xmm0
               	leaq	-0x108(%rbp), %rsi
               	leaq	0x740(%rsp), %rax
               	movups	%xmm0, 0x740(%rsp)
               	leaq	-0x118(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x118(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%r8d, %r8d
               	leaq	-0x108(%rbp), %rdi
               	movl	$0xa5, %eax
               	movq	%r8, %rcx
               	andq	$0x7, %rcx
               	sarxq	%rcx, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%r8, %r9
               	shlq	%r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rbx, %rsi
               	jmp	<addr>
               	incq	%r8
               	cmpl	$0x10, %r8d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rsi
               	movq	0x80(%rsp), %rdi
               	movq	0x88(%rsp), %r8
               	leaq	0x700(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movq	%rdi, 0x700(%rsp)
               	movq	%r8, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x340(%rsp)
               	leaq	0x340(%rsp), %rdi
               	leaq	0x700(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0x700(%rsp)
               	movq	%rcx, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x350(%rsp)
               	leaq	0x350(%rsp), %rcx
               	leaq	0x360(%rsp), %rax
               	movdqu	(%rdi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pblendw	$0xa5, %xmm14, %xmm15   # xmm15 = xmm14[0],xmm15[1],xmm14[2],xmm15[3,4],xmm14[5],xmm15[6],xmm14[7]
               	movdqu	%xmm15, (%rax)
               	movq	0x90(%rsp), %rcx
               	movq	0x98(%rsp), %rdi
               	leaq	0x710(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rcx, 0x710(%rsp)
               	movq	%rdi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x370(%rsp)
               	leaq	0x370(%rsp), %rdi
               	leaq	0x710(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rdx, 0x710(%rsp)
               	movq	%rsi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x380(%rsp)
               	leaq	0x380(%rsp), %rdx
               	leaq	0x390(%rsp), %rcx
               	movdqu	(%rdi), %xmm15
               	movdqu	(%rdx), %xmm14
               	pblendw	$0xa5, %xmm14, %xmm15   # xmm15 = xmm14[0],xmm15[1],xmm14[2],xmm15[3,4],xmm14[5],xmm15[6],xmm14[7]
               	movdqu	%xmm15, (%rcx)
               	leaq	0x720(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x730(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0x720(%rsp), %rax
               	movq	%rax, 0x120(%rsp)
               	movq	0x728(%rsp), %rax
               	movq	%rax, 0x128(%rsp)
               	movq	0x730(%rsp), %rcx
               	movq	%rcx, 0x130(%rsp)
               	movq	0x738(%rsp), %rdx
               	movq	%rdx, 0x138(%rsp)
               	movq	0x120(%rsp), %rdi
               	leaq	-0x108(%rbp), %rsi
               	movq	%rdi, 0x100(%rsp)
               	movq	%rax, 0x108(%rsp)
               	movq	%rcx, 0x110(%rsp)
               	movq	%rdx, 0x118(%rsp)
               	leaq	-0xe8(%rbp), %rdi
               	leaq	0x100(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%r8d, %r8d
               	leaq	-0x108(%rbp), %rdi
               	movl	$0xa5, %eax
               	sarxq	%r8, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movq	%r8, %r9
               	shlq	$0x2, %r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rsi
               	shlq	$0x2, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rbx, %rsi
               	jmp	<addr>
               	incq	%r8
               	cmpl	$0x8, %r8d
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x20(%rsp), %rdi
               	leaq	0x40(%rsp), %r8
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x700(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0x700(%rsp)
               	movq	%rcx, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	leaq	0x3a0(%rsp), %rax
               	movups	%xmm0, 0x3a0(%rsp)
               	movq	0x40(%rsp), %rcx
               	movq	0x48(%rsp), %rdi
               	leaq	0x700(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rcx, 0x700(%rsp)
               	movq	%rdi, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x3b0(%rsp)
               	leaq	0x3b0(%rsp), %rcx
               	leaq	0x3c0(%rsp), %rdi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0x5, %xmm14, %xmm15    # xmm15 = xmm14[0],xmm15[1],xmm14[2],xmm15[3]
               	movdqu	%xmm15, (%rdi)
               	movups	0x3c0(%rsp), %xmm0
               	leaq	0x710(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x710(%rsp)
               	movq	%rsi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm1
               	leaq	0x3d0(%rsp), %rax
               	movups	%xmm1, 0x3d0(%rsp)
               	movq	0x50(%rsp), %rcx
               	movq	0x58(%rsp), %rdx
               	leaq	0x710(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0x710(%rsp)
               	movq	%rdx, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm1
               	leaq	0x3e0(%rsp), %rcx
               	movups	%xmm1, 0x3e0(%rsp)
               	leaq	0x3f0(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0xa, %xmm14, %xmm15    # xmm15 = xmm15[0],xmm14[1],xmm15[2],xmm14[3]
               	movdqu	%xmm15, (%rdx)
               	movups	0x3f0(%rsp), %xmm1
               	movups	%xmm0, 0x720(%rsp)
               	movups	%xmm1, 0x730(%rsp)
               	leaq	0x120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0x720(%rsp), %rax
               	movq	%rax, 0x120(%rsp)
               	movq	0x728(%rsp), %rax
               	movq	%rax, 0x128(%rsp)
               	movq	0x730(%rsp), %rcx
               	movq	%rcx, 0x130(%rsp)
               	movq	0x738(%rsp), %rdx
               	movq	%rdx, 0x138(%rsp)
               	movq	0x120(%rsp), %rdi
               	leaq	-0x108(%rbp), %rsi
               	movq	%rdi, 0x100(%rsp)
               	movq	%rax, 0x108(%rsp)
               	movq	%rcx, 0x110(%rsp)
               	movq	%rdx, 0x118(%rsp)
               	leaq	-0xe8(%rbp), %rdi
               	leaq	0x100(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	leaq	0x400(%rsp), %rax
               	movups	0x140(%rsp), %xmm0
               	movups	%xmm0, 0x400(%rsp)
               	leaq	0x410(%rsp), %rcx
               	movups	0x150(%rsp), %xmm0
               	movups	%xmm0, 0x410(%rsp)
               	leaq	0x420(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0x5, %xmm14, %xmm15    # xmm15 = xmm14[0],xmm15[1],xmm14[2],xmm15[3]
               	movdqu	%xmm15, (%rdx)
               	movups	0x420(%rsp), %xmm0
               	leaq	-0x108(%rbp), %rsi
               	leaq	0x740(%rsp), %rax
               	movups	%xmm0, 0x740(%rsp)
               	leaq	-0x118(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x118(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%r8d, %r8d
               	leaq	-0x108(%rbp), %rdi
               	movl	$0x5a, %eax
               	movq	%r8, %rcx
               	andq	$0x7, %rcx
               	sarxq	%rcx, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%r8, %r9
               	shlq	%r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rbx, %rsi
               	jmp	<addr>
               	incq	%r8
               	cmpl	$0x10, %r8d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rsi
               	movq	0xa0(%rsp), %rdi
               	movq	0xa8(%rsp), %r8
               	leaq	0x700(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movq	%rdi, 0x700(%rsp)
               	movq	%r8, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x430(%rsp)
               	leaq	0x430(%rsp), %rdi
               	leaq	0x700(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0x700(%rsp)
               	movq	%rcx, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x440(%rsp)
               	leaq	0x440(%rsp), %rcx
               	leaq	0x450(%rsp), %rax
               	movdqu	(%rdi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pblendw	$0x5a, %xmm14, %xmm15   # xmm15 = xmm15[0],xmm14[1],xmm15[2],xmm14[3,4],xmm15[5],xmm14[6],xmm15[7]
               	movdqu	%xmm15, (%rax)
               	movq	0xb0(%rsp), %rcx
               	movq	0xb8(%rsp), %rdi
               	leaq	0x710(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rcx, 0x710(%rsp)
               	movq	%rdi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x460(%rsp)
               	leaq	0x460(%rsp), %rdi
               	leaq	0x710(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rdx, 0x710(%rsp)
               	movq	%rsi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x470(%rsp)
               	leaq	0x470(%rsp), %rdx
               	leaq	0x480(%rsp), %rcx
               	movdqu	(%rdi), %xmm15
               	movdqu	(%rdx), %xmm14
               	pblendw	$0x5a, %xmm14, %xmm15   # xmm15 = xmm15[0],xmm14[1],xmm15[2],xmm14[3,4],xmm15[5],xmm14[6],xmm15[7]
               	movdqu	%xmm15, (%rcx)
               	leaq	0x720(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x730(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0x720(%rsp), %rax
               	movq	%rax, 0x120(%rsp)
               	movq	0x728(%rsp), %rax
               	movq	%rax, 0x128(%rsp)
               	movq	0x730(%rsp), %rcx
               	movq	%rcx, 0x130(%rsp)
               	movq	0x738(%rsp), %rdx
               	movq	%rdx, 0x138(%rsp)
               	movq	0x120(%rsp), %rdi
               	leaq	-0x108(%rbp), %rsi
               	movq	%rdi, 0x100(%rsp)
               	movq	%rax, 0x108(%rsp)
               	movq	%rcx, 0x110(%rsp)
               	movq	%rdx, 0x118(%rsp)
               	leaq	-0xe8(%rbp), %rdi
               	leaq	0x100(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%r8d, %r8d
               	leaq	-0x108(%rbp), %rdi
               	movl	$0x5a, %eax
               	sarxq	%r8, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movq	%r8, %r9
               	shlq	$0x2, %r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rsi
               	shlq	$0x2, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rbx, %rsi
               	jmp	<addr>
               	incq	%r8
               	cmpl	$0x8, %r8d
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x20(%rsp), %rdi
               	leaq	0x40(%rsp), %r8
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x700(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0x700(%rsp)
               	movq	%rcx, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	leaq	0x490(%rsp), %rax
               	movups	%xmm0, 0x490(%rsp)
               	movq	0x40(%rsp), %rcx
               	movq	0x48(%rsp), %rdi
               	leaq	0x700(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rcx, 0x700(%rsp)
               	movq	%rdi, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x4a0(%rsp)
               	leaq	0x4a0(%rsp), %rcx
               	leaq	0x4b0(%rsp), %rdi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0xa, %xmm14, %xmm15    # xmm15 = xmm15[0],xmm14[1],xmm15[2],xmm14[3]
               	movdqu	%xmm15, (%rdi)
               	movups	0x4b0(%rsp), %xmm0
               	leaq	0x710(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x710(%rsp)
               	movq	%rsi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm1
               	leaq	0x4c0(%rsp), %rax
               	movups	%xmm1, 0x4c0(%rsp)
               	movq	0x50(%rsp), %rcx
               	movq	0x58(%rsp), %rdx
               	leaq	0x710(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0x710(%rsp)
               	movq	%rdx, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm1
               	leaq	0x4d0(%rsp), %rcx
               	movups	%xmm1, 0x4d0(%rsp)
               	leaq	0x4e0(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0x5, %xmm14, %xmm15    # xmm15 = xmm14[0],xmm15[1],xmm14[2],xmm15[3]
               	movdqu	%xmm15, (%rdx)
               	movups	0x4e0(%rsp), %xmm1
               	movups	%xmm0, 0x720(%rsp)
               	movups	%xmm1, 0x730(%rsp)
               	leaq	0x120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0x720(%rsp), %rax
               	movq	%rax, 0x120(%rsp)
               	movq	0x728(%rsp), %rax
               	movq	%rax, 0x128(%rsp)
               	movq	0x730(%rsp), %rcx
               	movq	%rcx, 0x130(%rsp)
               	movq	0x738(%rsp), %rdx
               	movq	%rdx, 0x138(%rsp)
               	movq	0x120(%rsp), %rdi
               	leaq	-0x108(%rbp), %rsi
               	movq	%rdi, 0x100(%rsp)
               	movq	%rax, 0x108(%rsp)
               	movq	%rcx, 0x110(%rsp)
               	movq	%rdx, 0x118(%rsp)
               	leaq	-0xe8(%rbp), %rdi
               	leaq	0x100(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	leaq	0x4f0(%rsp), %rax
               	movups	0x140(%rsp), %xmm0
               	movups	%xmm0, 0x4f0(%rsp)
               	leaq	0x500(%rsp), %rcx
               	movups	0x150(%rsp), %xmm0
               	movups	%xmm0, 0x500(%rsp)
               	leaq	0x510(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0xa, %xmm14, %xmm15    # xmm15 = xmm15[0],xmm14[1],xmm15[2],xmm14[3]
               	movdqu	%xmm15, (%rdx)
               	movups	0x510(%rsp), %xmm0
               	leaq	-0x108(%rbp), %rsi
               	leaq	0x740(%rsp), %rax
               	movups	%xmm0, 0x740(%rsp)
               	leaq	-0x118(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x118(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%r8d, %r8d
               	leaq	-0x108(%rbp), %rdi
               	movl	$0x81, %eax
               	movq	%r8, %rcx
               	andq	$0x7, %rcx
               	sarxq	%rcx, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%r8, %r9
               	shlq	%r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rbx, %rsi
               	jmp	<addr>
               	incq	%r8
               	cmpl	$0x10, %r8d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0xc0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rsi
               	movq	0xc0(%rsp), %rdi
               	movq	0xc8(%rsp), %r8
               	leaq	0x700(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movq	%rdi, 0x700(%rsp)
               	movq	%r8, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x520(%rsp)
               	leaq	0x520(%rsp), %rdi
               	leaq	0x700(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0x700(%rsp)
               	movq	%rcx, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x530(%rsp)
               	leaq	0x530(%rsp), %rcx
               	leaq	0x540(%rsp), %rax
               	movdqu	(%rdi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pblendw	$0x81, %xmm14, %xmm15   # xmm15 = xmm14[0],xmm15[1,2,3,4,5,6],xmm14[7]
               	movdqu	%xmm15, (%rax)
               	movq	0xd0(%rsp), %rcx
               	movq	0xd8(%rsp), %rdi
               	leaq	0x710(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rcx, 0x710(%rsp)
               	movq	%rdi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x550(%rsp)
               	leaq	0x550(%rsp), %rdi
               	leaq	0x710(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rdx, 0x710(%rsp)
               	movq	%rsi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x560(%rsp)
               	leaq	0x560(%rsp), %rdx
               	leaq	0x570(%rsp), %rcx
               	movdqu	(%rdi), %xmm15
               	movdqu	(%rdx), %xmm14
               	pblendw	$0x81, %xmm14, %xmm15   # xmm15 = xmm14[0],xmm15[1,2,3,4,5,6],xmm14[7]
               	movdqu	%xmm15, (%rcx)
               	leaq	0x720(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x730(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0x720(%rsp), %rax
               	movq	%rax, 0x120(%rsp)
               	movq	0x728(%rsp), %rax
               	movq	%rax, 0x128(%rsp)
               	movq	0x730(%rsp), %rcx
               	movq	%rcx, 0x130(%rsp)
               	movq	0x738(%rsp), %rdx
               	movq	%rdx, 0x138(%rsp)
               	movq	0x120(%rsp), %rdi
               	leaq	-0x108(%rbp), %rsi
               	movq	%rdi, 0x100(%rsp)
               	movq	%rax, 0x108(%rsp)
               	movq	%rcx, 0x110(%rsp)
               	movq	%rdx, 0x118(%rsp)
               	leaq	-0xe8(%rbp), %rdi
               	leaq	0x100(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%r13, %r10
               	orq	%rax, %r10
               	movq	%r10, -0x130(%rbp)
               	xorl	%r13d, %r13d
               	leaq	-0x108(%rbp), %r15
               	movl	$0x4, %r10d
               	movq	%r10, -0x128(%rbp)
               	movl	$0x81, %eax
               	sarxq	%r13, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	jmp	<addr>
               	movq	%rbx, %rsi
               	movl	$0x4, %eax
               	xorl	%ecx, %ecx
               	movq	%rsi, %rdi
               	movq	%r13, %rdx
               	movq	%rax, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r15, %rdi
               	movq	%r13, %rdx
               	movq	-0x128(%rbp), %rsi
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x8, %r13d
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x20(%rsp), %rdi
               	leaq	0x40(%rsp), %r8
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x700(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0x700(%rsp)
               	movq	%rcx, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	leaq	0x580(%rsp), %rax
               	movups	%xmm0, 0x580(%rsp)
               	movq	0x40(%rsp), %rcx
               	movq	0x48(%rsp), %rdi
               	leaq	0x700(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rcx, 0x700(%rsp)
               	movq	%rdi, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x590(%rsp)
               	leaq	0x590(%rsp), %rcx
               	leaq	0x5a0(%rsp), %rdi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0x1, %xmm14, %xmm15    # xmm15 = xmm14[0],xmm15[1,2,3]
               	movdqu	%xmm15, (%rdi)
               	movups	0x5a0(%rsp), %xmm0
               	leaq	0x710(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x710(%rsp)
               	movq	%rsi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm1
               	leaq	0x5b0(%rsp), %rax
               	movups	%xmm1, 0x5b0(%rsp)
               	movq	0x50(%rsp), %rcx
               	movq	0x58(%rsp), %rdx
               	leaq	0x710(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0x710(%rsp)
               	movq	%rdx, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm1
               	leaq	0x5c0(%rsp), %rcx
               	movups	%xmm1, 0x5c0(%rsp)
               	leaq	0x5d0(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0x8, %xmm14, %xmm15    # xmm15 = xmm15[0,1,2],xmm14[3]
               	movdqu	%xmm15, (%rdx)
               	movups	0x5d0(%rsp), %xmm1
               	movups	%xmm0, 0x720(%rsp)
               	movups	%xmm1, 0x730(%rsp)
               	leaq	0x120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0x720(%rsp), %rax
               	movq	%rax, 0x120(%rsp)
               	movq	0x728(%rsp), %rax
               	movq	%rax, 0x128(%rsp)
               	movq	0x730(%rsp), %rcx
               	movq	%rcx, 0x130(%rsp)
               	movq	0x738(%rsp), %rdx
               	movq	%rdx, 0x138(%rsp)
               	movq	0x120(%rsp), %rdi
               	leaq	-0x108(%rbp), %rsi
               	movq	%rdi, 0x100(%rsp)
               	movq	%rax, 0x108(%rsp)
               	movq	%rcx, 0x110(%rsp)
               	movq	%rdx, 0x118(%rsp)
               	leaq	-0xe8(%rbp), %rdi
               	leaq	0x100(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x130(%rbp), %r13
               	orq	%rax, %r13
               	leaq	0x5e0(%rsp), %rax
               	movups	0x140(%rsp), %xmm0
               	movups	%xmm0, 0x5e0(%rsp)
               	leaq	0x5f0(%rsp), %rcx
               	movups	0x150(%rsp), %xmm0
               	movups	%xmm0, 0x5f0(%rsp)
               	leaq	0x600(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0x1, %xmm14, %xmm15    # xmm15 = xmm14[0],xmm15[1,2,3]
               	movdqu	%xmm15, (%rdx)
               	movups	0x600(%rsp), %xmm0
               	leaq	-0x108(%rbp), %rsi
               	leaq	0x740(%rsp), %rax
               	movups	%xmm0, 0x740(%rsp)
               	leaq	-0x118(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x118(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%r13, %r10
               	orq	%rax, %r10
               	movq	%r10, -0x130(%rbp)
               	xorl	%r13d, %r13d
               	leaq	-0x108(%rbp), %r15
               	movl	$0x2, %r10d
               	movq	%r10, -0x128(%rbp)
               	movl	$0xf, %eax
               	movq	%r13, %rcx
               	andq	$0x7, %rcx
               	sarxq	%rcx, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	jmp	<addr>
               	movq	%rbx, %rsi
               	movl	$0x2, %eax
               	xorl	%ecx, %ecx
               	movq	%rsi, %rdi
               	movq	%r13, %rdx
               	movq	%rax, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r15, %rdi
               	movq	%r13, %rdx
               	movq	-0x128(%rbp), %rsi
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x10, %r13d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0xe0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rsi
               	leaq	0x100(%rsp), %rdi
               	movq	0xe0(%rsp), %r8
               	movq	0xe8(%rsp), %r9
               	leaq	0x700(%rsp), %r13
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r13)
               	movq	%r8, 0x700(%rsp)
               	movq	%r9, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x610(%rsp)
               	leaq	0x610(%rsp), %r8
               	leaq	0x700(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movq	%rax, 0x700(%rsp)
               	movq	%rcx, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x620(%rsp)
               	leaq	0x620(%rsp), %rcx
               	leaq	0x630(%rsp), %rax
               	movdqu	(%r8), %xmm15
               	movdqu	(%rcx), %xmm14
               	pblendw	$0xf, %xmm14, %xmm15    # xmm15 = xmm14[0,1,2,3],xmm15[4,5,6,7]
               	movdqu	%xmm15, (%rax)
               	movq	0xf0(%rsp), %rcx
               	movq	0xf8(%rsp), %r8
               	leaq	0x710(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movq	%rcx, 0x710(%rsp)
               	movq	%r8, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x640(%rsp)
               	leaq	0x640(%rsp), %r8
               	leaq	0x710(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rdx, 0x710(%rsp)
               	movq	%rsi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x650(%rsp)
               	leaq	0x650(%rsp), %rdx
               	leaq	0x660(%rsp), %rcx
               	movdqu	(%r8), %xmm15
               	movdqu	(%rdx), %xmm14
               	pblendw	$0xf, %xmm14, %xmm15    # xmm15 = xmm14[0,1,2,3],xmm15[4,5,6,7]
               	movdqu	%xmm15, (%rcx)
               	leaq	0x720(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x730(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0x720(%rsp), %rax
               	movq	%rax, 0x120(%rsp)
               	movq	0x728(%rsp), %rax
               	movq	%rax, 0x128(%rsp)
               	movq	0x730(%rsp), %rax
               	movq	%rax, 0x130(%rsp)
               	movq	0x738(%rsp), %rax
               	leaq	0x120(%rsp), %rcx
               	movq	%rax, 0x138(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x100(%rsp), %r9
               	leaq	-0x108(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x130(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x130(%rbp)
               	xorl	%r13d, %r13d
               	leaq	-0x108(%rbp), %r15
               	movl	$0x4, %r10d
               	movq	%r10, -0x128(%rbp)
               	movl	$0xf, %eax
               	sarxq	%r13, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	jmp	<addr>
               	movq	%rbx, %rsi
               	movl	$0x4, %eax
               	xorl	%ecx, %ecx
               	movq	%rsi, %rdi
               	movq	%r13, %rdx
               	movq	%rax, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r15, %rdi
               	movq	%r13, %rdx
               	movq	-0x128(%rbp), %rsi
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x8, %r13d
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x20(%rsp), %rdi
               	leaq	0x40(%rsp), %r8
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x100(%rsp), %rdi
               	leaq	0x700(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0x700(%rsp)
               	movq	%rcx, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x670(%rsp)
               	leaq	0x670(%rsp), %rax
               	movq	0x40(%rsp), %rcx
               	movq	0x48(%rsp), %r8
               	leaq	0x700(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movq	%rcx, 0x700(%rsp)
               	movq	%r8, 0x708(%rsp)
               	movups	0x700(%rsp), %xmm0
               	movups	%xmm0, 0x680(%rsp)
               	leaq	0x680(%rsp), %rcx
               	leaq	0x690(%rsp), %r8
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0xf, %xmm14, %xmm15    # xmm15 = xmm14[0,1,2,3]
               	movdqu	%xmm15, (%r8)
               	movups	0x690(%rsp), %xmm0
               	leaq	0x710(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x710(%rsp)
               	movq	%rsi, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm1
               	leaq	0x6a0(%rsp), %rax
               	movups	%xmm1, 0x6a0(%rsp)
               	movq	0x50(%rsp), %rcx
               	movq	0x58(%rsp), %rdx
               	leaq	0x710(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0x710(%rsp)
               	movq	%rdx, 0x718(%rsp)
               	movups	0x710(%rsp), %xmm1
               	leaq	0x6b0(%rsp), %rcx
               	movups	%xmm1, 0x6b0(%rsp)
               	leaq	0x6c0(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0x0, %xmm14, %xmm15    # xmm15 = xmm15[0,1,2,3]
               	movdqu	%xmm15, (%rdx)
               	movups	0x6c0(%rsp), %xmm1
               	movups	%xmm0, 0x720(%rsp)
               	movups	%xmm1, 0x730(%rsp)
               	leaq	0x120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0x720(%rsp), %rax
               	movq	%rax, 0x120(%rsp)
               	movq	0x728(%rsp), %rax
               	movq	%rax, 0x128(%rsp)
               	movq	0x730(%rsp), %rax
               	movq	%rax, 0x130(%rsp)
               	movq	0x738(%rsp), %rax
               	leaq	0x120(%rsp), %rcx
               	movq	%rax, 0x138(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x100(%rsp), %r9
               	leaq	-0x108(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x130(%rbp), %r13
               	orq	%rax, %r13
               	leaq	0x6d0(%rsp), %rax
               	movups	0x140(%rsp), %xmm0
               	movups	%xmm0, 0x6d0(%rsp)
               	leaq	0x6e0(%rsp), %rcx
               	movups	0x150(%rsp), %xmm0
               	movups	%xmm0, 0x6e0(%rsp)
               	leaq	0x6f0(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	blendps	$0xf, %xmm14, %xmm15    # xmm15 = xmm14[0,1,2,3]
               	movdqu	%xmm15, (%rdx)
               	leaq	0x100(%rsp), %r9
               	movups	0x6f0(%rsp), %xmm0
               	movups	%xmm0, 0x100(%rsp)
               	leaq	-0x108(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%eax, %eax
               	leaq	-0x108(%rbp), %rdx
               	movzbq	(%r14,%rax), %rcx
               	testb	$-0x80, %cl
               	je	<addr>
               	movzbq	(%r12,%rax), %rcx
               	jmp	<addr>
               	movzbq	(%rbx,%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rax
               	movups	(%r14), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r14), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rsi
               	movq	0x18(%rsp), %rdi
               	movq	0x20(%rsp), %rdx
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %rbx
               	movq	0x100(%rsp), %r12
               	movq	0x108(%rsp), %r14
               	movq	0x110(%rsp), %r15
               	movq	0x118(%rsp), %r10
               	movq	%r10, -0x128(%rbp)
               	leaq	0x100(%rsp), %r10
               	movq	%r10, -0x130(%rbp)
               	movq	-0x130(%rbp), %r10
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r10)
               	movq	%rax, 0x100(%rsp)
               	movq	%rcx, 0x108(%rsp)
               	movups	0x100(%rsp), %xmm0
               	leaq	0x100(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x100(%rsp)
               	movq	%r8, 0x108(%rsp)
               	movups	0x100(%rsp), %xmm1
               	leaq	0x100(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r12, 0x100(%rsp)
               	movq	%r14, 0x108(%rsp)
               	movups	0x100(%rsp), %xmm2
               	movups	%xmm0, (%rsp)
               	movups	%xmm1, 0x20(%rsp)
               	movups	%xmm2, 0x40(%rsp)
               	xorl	%eax, %eax
               	leaq	0x40(%rsp), %rcx
               	movsbq	(%rcx,%rax), %rcx
               	testb	$-0x80, %cl
               	je	<addr>
               	leaq	(%rsp), %rcx
               	leaq	0x20(%rsp), %rdx
               	movsbq	(%rdx,%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	(%rsp), %xmm0
               	leaq	0x100(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rsi, 0x100(%rsp)
               	movq	%rdi, 0x108(%rsp)
               	leaq	0x100(%rsp), %rax
               	movups	0x100(%rsp), %xmm1
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0x100(%rsp)
               	movq	%rbx, 0x108(%rsp)
               	leaq	0x100(%rsp), %rax
               	movups	0x100(%rsp), %xmm2
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r15, 0x100(%rsp)
               	movq	-0x128(%rbp), %r10
               	movq	%r10, 0x108(%rsp)
               	movups	0x100(%rsp), %xmm3
               	leaq	(%rsp), %rcx
               	movups	%xmm1, (%rsp)
               	leaq	0x20(%rsp), %rdx
               	movups	%xmm2, 0x20(%rsp)
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm3, 0x40(%rsp)
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rdi
               	testb	$-0x80, %dil
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movb	%dil, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	(%rsp), %xmm1
               	movups	%xmm0, 0x40(%rsp)
               	movups	%xmm1, 0x100(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x100(%rsp), %rdx
               	movq	0x108(%rsp), %rsi
               	movq	%rax, 0x120(%rsp)
               	movq	%rcx, 0x128(%rsp)
               	movq	%rdx, 0x130(%rsp)
               	movq	%rsi, 0x138(%rsp)
               	leaq	0x120(%rsp), %r9
               	leaq	-0x108(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%r13, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leaq	-0x160(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<check_extensions>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x400, %rsp            # imm = 0x400
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	leaq	0x1a0(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movups	%xmm14, 0x20(%rcx)
               	movups	%xmm14, 0x30(%rcx)
               	movups	%xmm14, 0x40(%rcx)
               	movups	%xmm14, 0x50(%rcx)
               	movups	%xmm14, 0x60(%rcx)
               	movups	%xmm14, 0x70(%rcx)
               	movups	%xmm14, 0x80(%rcx)
               	movups	%xmm14, 0x90(%rcx)
               	movups	%xmm14, 0xa0(%rcx)
               	movups	%xmm14, 0xb0(%rcx)
               	movups	%xmm14, 0xc0(%rcx)
               	movups	%xmm14, 0xd0(%rcx)
               	movups	%xmm14, 0xe0(%rcx)
               	movups	%xmm14, 0xf0(%rcx)
               	movups	%xmm14, 0x100(%rcx)
               	movups	%xmm14, 0x110(%rcx)
               	movups	%xmm14, 0x120(%rcx)
               	movups	%xmm14, 0x130(%rcx)
               	movups	%xmm14, 0x140(%rcx)
               	movups	%xmm14, 0x150(%rcx)
               	movups	%xmm14, 0x160(%rcx)
               	movups	%xmm14, 0x170(%rcx)
               	leaq	0x180(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x1b0(%rsp), %rdx
               	movdqu	(%rcx), %xmm14
               	pmovsxbw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	0x1c0(%rsp), %rdx
               	movdqu	(%rcx), %xmm15
               	psrldq	$0x8, %xmm15            # xmm15 = xmm15[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rdx)
               	leaq	0x1d0(%rsp), %rcx
               	movdqu	(%rdx), %xmm14
               	pmovsxbw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movq	0x1b0(%rsp), %rcx
               	movq	0x1b8(%rsp), %rdx
               	movq	0x1d0(%rsp), %rsi
               	movq	0x1d8(%rsp), %rdi
               	movq	%rcx, (%rsp)
               	movq	%rdx, 0x8(%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdi, 0x18(%rsp)
               	leaq	0x180(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x1e0(%rsp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovsxbd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	0x1f0(%rsp), %rax
               	movdqu	(%rcx), %xmm15
               	psrldq	$0x4, %xmm15            # xmm15 = xmm15[4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero,zero
               	movdqu	%xmm15, (%rax)
               	leaq	0x200(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovsxbd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movq	0x1e0(%rsp), %rdx
               	movq	0x1e8(%rsp), %rsi
               	movq	0x200(%rsp), %rdi
               	movq	0x208(%rsp), %r8
               	leaq	(%rsp), %rcx
               	leaq	0x20(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	leaq	0x1a0(%rsp), %rdx
               	leaq	0x180(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x210(%rsp), %rsi
               	movdqu	(%rax), %xmm14
               	pmovsxbq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	0x220(%rsp), %rsi
               	movdqu	(%rax), %xmm15
               	psrldq	$0x2, %xmm15            # xmm15 = xmm15[2,3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero
               	movdqu	%xmm15, (%rsi)
               	leaq	0x230(%rsp), %rax
               	movdqu	(%rsi), %xmm14
               	pmovsxbq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	0x210(%rsp), %rsi
               	movq	0x218(%rsp), %rdi
               	movq	0x230(%rsp), %r8
               	movq	0x238(%rsp), %r9
               	leaq	0x40(%rcx), %rax
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movq	%r8, 0x10(%rax)
               	movq	%r9, 0x18(%rax)
               	leaq	0x180(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x240(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovsxwd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x250(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x8, %xmm15            # xmm15 = xmm15[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	0x260(%rsp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovsxwd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	0x240(%rsp), %rdx
               	movq	0x248(%rsp), %rsi
               	movq	0x260(%rsp), %rdi
               	movq	0x268(%rsp), %r8
               	leaq	(%rsp), %rcx
               	leaq	0x60(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	leaq	0x1a0(%rsp), %rdx
               	leaq	0x180(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x270(%rsp), %rsi
               	movdqu	(%rax), %xmm14
               	pmovsxwq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	0x280(%rsp), %rsi
               	movdqu	(%rax), %xmm15
               	psrldq	$0x4, %xmm15            # xmm15 = xmm15[4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero,zero
               	movdqu	%xmm15, (%rsi)
               	leaq	0x290(%rsp), %rax
               	movdqu	(%rsi), %xmm14
               	pmovsxwq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	0x270(%rsp), %rsi
               	movq	0x278(%rsp), %rdi
               	movq	0x290(%rsp), %r8
               	movq	0x298(%rsp), %r9
               	leaq	0x80(%rcx), %rax
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movq	%r8, 0x10(%rax)
               	movq	%r9, 0x18(%rax)
               	leaq	0x180(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x2a0(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovsxdq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x2b0(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x8, %xmm15            # xmm15 = xmm15[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	0x2c0(%rsp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovsxdq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	0x2a0(%rsp), %rdx
               	movq	0x2a8(%rsp), %rsi
               	movq	0x2c0(%rsp), %rdi
               	movq	0x2c8(%rsp), %r8
               	leaq	(%rsp), %rcx
               	leaq	0xa0(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	leaq	0x1a0(%rsp), %rdx
               	leaq	0x180(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x2d0(%rsp), %rsi
               	movdqu	(%rax), %xmm14
               	pmovzxbw	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,xmm14[1],zero,xmm14[2],zero,xmm14[3],zero,xmm14[4],zero,xmm14[5],zero,xmm14[6],zero,xmm14[7],zero
               	movdqu	%xmm15, (%rsi)
               	leaq	0x2e0(%rsp), %rsi
               	movdqu	(%rax), %xmm15
               	psrldq	$0x8, %xmm15            # xmm15 = xmm15[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rsi)
               	leaq	0x2f0(%rsp), %rax
               	movdqu	(%rsi), %xmm14
               	pmovzxbw	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,xmm14[1],zero,xmm14[2],zero,xmm14[3],zero,xmm14[4],zero,xmm14[5],zero,xmm14[6],zero,xmm14[7],zero
               	movdqu	%xmm15, (%rax)
               	movq	0x2d0(%rsp), %rsi
               	movq	0x2d8(%rsp), %rdi
               	movq	0x2f0(%rsp), %r8
               	movq	0x2f8(%rsp), %r9
               	leaq	0xc0(%rcx), %rax
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movq	%r8, 0x10(%rax)
               	movq	%r9, 0x18(%rax)
               	leaq	0x180(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x300(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovzxbd	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,zero,zero,xmm14[1],zero,zero,zero,xmm14[2],zero,zero,zero,xmm14[3],zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	0x310(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x4, %xmm15            # xmm15 = xmm15[4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	0x320(%rsp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovzxbd	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,zero,zero,xmm14[1],zero,zero,zero,xmm14[2],zero,zero,zero,xmm14[3],zero,zero,zero
               	movdqu	%xmm15, (%rax)
               	movq	0x300(%rsp), %rdx
               	movq	0x308(%rsp), %rsi
               	movq	0x320(%rsp), %rdi
               	movq	0x328(%rsp), %r8
               	leaq	(%rsp), %rcx
               	leaq	0xe0(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	leaq	0x1a0(%rsp), %rdx
               	leaq	0x180(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x330(%rsp), %rsi
               	movdqu	(%rax), %xmm14
               	pmovzxbq	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,zero,zero,zero,zero,zero,zero,xmm14[1],zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rsi)
               	leaq	0x340(%rsp), %rsi
               	movdqu	(%rax), %xmm15
               	psrldq	$0x2, %xmm15            # xmm15 = xmm15[2,3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero
               	movdqu	%xmm15, (%rsi)
               	leaq	0x350(%rsp), %rax
               	movdqu	(%rsi), %xmm14
               	pmovzxbq	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,zero,zero,zero,zero,zero,zero,xmm14[1],zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rax)
               	movq	0x330(%rsp), %rsi
               	movq	0x338(%rsp), %rdi
               	movq	0x350(%rsp), %r8
               	movq	0x358(%rsp), %r9
               	leaq	0x100(%rcx), %rax
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movq	%r8, 0x10(%rax)
               	movq	%r9, 0x18(%rax)
               	leaq	0x180(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x360(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovzxwd	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,xmm14[1],zero,xmm14[2],zero,xmm14[3],zero
               	movdqu	%xmm15, (%rcx)
               	leaq	0x370(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x8, %xmm15            # xmm15 = xmm15[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	0x380(%rsp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovzxwd	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,xmm14[1],zero,xmm14[2],zero,xmm14[3],zero
               	movdqu	%xmm15, (%rax)
               	movq	0x360(%rsp), %rdx
               	movq	0x368(%rsp), %rsi
               	movq	0x380(%rsp), %rdi
               	movq	0x388(%rsp), %r8
               	leaq	(%rsp), %rcx
               	leaq	0x120(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	leaq	0x1a0(%rsp), %rdx
               	leaq	0x180(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x390(%rsp), %rsi
               	movdqu	(%rax), %xmm14
               	pmovzxwq	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,zero,zero,xmm14[1],zero,zero,zero
               	movdqu	%xmm15, (%rsi)
               	leaq	0x3a0(%rsp), %rsi
               	movdqu	(%rax), %xmm15
               	psrldq	$0x4, %xmm15            # xmm15 = xmm15[4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero,zero
               	movdqu	%xmm15, (%rsi)
               	leaq	0x3b0(%rsp), %rax
               	movdqu	(%rsi), %xmm14
               	pmovzxwq	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,zero,zero,xmm14[1],zero,zero,zero
               	movdqu	%xmm15, (%rax)
               	movq	0x390(%rsp), %rsi
               	movq	0x398(%rsp), %rdi
               	movq	0x3b0(%rsp), %r8
               	movq	0x3b8(%rsp), %r9
               	leaq	0x140(%rcx), %rax
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movq	%r8, 0x10(%rax)
               	movq	%r9, 0x18(%rax)
               	leaq	0x180(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x3c0(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovzxdq	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,xmm14[1],zero
               	movdqu	%xmm15, (%rcx)
               	leaq	0x3d0(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x8, %xmm15            # xmm15 = xmm15[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	0x3e0(%rsp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovzxdq	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,xmm14[1],zero
               	movdqu	%xmm15, (%rax)
               	movq	0x3c0(%rsp), %rcx
               	movq	0x3c8(%rsp), %rdx
               	movq	0x3e0(%rsp), %rsi
               	movq	0x3e8(%rsp), %rdi
               	leaq	(%rsp), %rax
               	addq	$0x160, %rax            # imm = 0x160
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	xorl	%r13d, %r13d
               	leaq	<rip>, %rax # <addr>
               	imulq	$0x2aaaaaab, %r13, %rcx # imm = 0x2AAAAAAB
               	shrq	$0x20, %rcx
               	imulq	$0x6, %rcx, %rcx
               	movq	%r13, %rdx
               	subq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	xorl	%esi, %esi
               	movl	(%rax), %r9d
               	movl	0x4(%rax), %r8d
               	movl	$0x20, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %esi
               	jge	<addr>
               	leaq	-0x40(%rbp), %rdx
               	cmpl	$0x6, %r13d
               	setl	%r12b
               	movzbq	%r12b, %r12
               	xorl	%ecx, %ecx
               	leaq	-0x1(%r9), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	movq	%r9, %rdi
               	imulq	%rsi, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rbx,%rdi), %rdi
               	orq	%rdi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	cmpl	$0x8, %r9d
               	jge	<addr>
               	movq	%r9, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movq	$-0x1, %rdi
               	movslq	%eax, %rax
               	shlxq	%rax, %rdi, %rax
               	orq	%rax, %rcx
               	xorl	%eax, %eax
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movq	%r8, %rdi
               	imulq	%rsi, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	movslq	%r12d, %r12
               	shrxq	%r12, %rcx, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rdx,%rdi)
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	incq	%rsi
               	movl	$0x20, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %esi
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	%r13, %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x180(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r13
               	cmpl	$0xc, %r13d
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x20, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<check_mpsadbw>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	0x40(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rbx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r12), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%r15d, %r15d
               	xorl	%esi, %esi
               	leaq	(%r15,%r15,2), %rax
               	movslq	%eax, %rax
               	sarxq	%rax, %rsi, %rcx
               	movq	%r15, %rax
               	shlq	$0x4, %rax
               	movslq	%ecx, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x2, %rdx
               	andq	$0x1, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rax,%rdx), %rdi
               	andq	$0x3, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rax,%rcx), %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rdi,%rsi), %rcx
               	addq	%rax, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%r12,%r9), %r9
               	subq	%r9, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movq	%r15, %rax
               	shlq	$0x3, %rax
               	leaq	(%rax,%rsi), %r9
               	movslq	%edx, %rdx
               	xorl	%eax, %eax
               	movq	%r9, %r13
               	shlq	%r13
               	addq	%rax, %r13
               	movslq	%r13d, %r13
               	movq	%rax, %r14
               	shlq	$0x3, %r14
               	shrxq	%r14, %rdx, %r14
               	andq	$0xff, %r14
               	movb	%r14b, (%rcx,%r13)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	incq	%r15
               	cmpl	$0x2, %r15d
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	xorl	%esi, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x48(%rbp)
               	xorl	%r15d, %r15d
               	movl	$0x5, %eax
               	leaq	(%r15,%r15,2), %rcx
               	movslq	%ecx, %rcx
               	sarxq	%rcx, %rax, %rcx
               	movq	%r15, %rax
               	shlq	$0x4, %rax
               	movslq	%ecx, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x2, %rdx
               	andq	$0x1, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rax,%rdx), %rdi
               	andq	$0x3, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rax,%rcx), %r8
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rdi,%rsi), %rcx
               	addq	%rax, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%r12,%r9), %r9
               	subq	%r9, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movq	%r15, %rax
               	shlq	$0x3, %rax
               	leaq	(%rax,%rsi), %r9
               	movslq	%edx, %rdx
               	xorl	%eax, %eax
               	movq	%r9, %r13
               	shlq	%r13
               	addq	%rax, %r13
               	movslq	%r13d, %r13
               	movq	%rax, %r14
               	shlq	$0x3, %r14
               	shrxq	%r14, %rdx, %r14
               	andq	$0xff, %r14
               	movb	%r14b, (%rcx,%r13)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	incq	%r15
               	cmpl	$0x2, %r15d
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x5, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x48(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x48(%rbp)
               	xorl	%r15d, %r15d
               	movl	$0x2d, %eax
               	leaq	(%r15,%r15,2), %rcx
               	movslq	%ecx, %rcx
               	sarxq	%rcx, %rax, %rcx
               	movq	%r15, %rax
               	shlq	$0x4, %rax
               	movslq	%ecx, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x2, %rdx
               	andq	$0x1, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rax,%rdx), %rdi
               	andq	$0x3, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rax,%rcx), %r8
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rdi,%rsi), %rcx
               	addq	%rax, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%r12,%r9), %r9
               	subq	%r9, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movq	%r15, %rax
               	shlq	$0x3, %rax
               	leaq	(%rax,%rsi), %r9
               	movslq	%edx, %rdx
               	xorl	%eax, %eax
               	movq	%r9, %r13
               	shlq	%r13
               	addq	%rax, %r13
               	movslq	%r13d, %r13
               	movq	%rax, %r14
               	shlq	$0x3, %r14
               	shrxq	%r14, %rdx, %r14
               	andq	$0xff, %r14
               	movb	%r14b, (%rcx,%r13)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	incq	%r15
               	cmpl	$0x2, %r15d
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x2d, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x48(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x48(%rbp)
               	xorl	%r15d, %r15d
               	movl	$0x3f, %eax
               	leaq	(%r15,%r15,2), %rcx
               	movslq	%ecx, %rcx
               	sarxq	%rcx, %rax, %rcx
               	movq	%r15, %rax
               	shlq	$0x4, %rax
               	movslq	%ecx, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x2, %rdx
               	andq	$0x1, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rax,%rdx), %rdi
               	andq	$0x3, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rax,%rcx), %r8
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rdi,%rsi), %rcx
               	addq	%rax, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%r12,%r9), %r9
               	subq	%r9, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movq	%r15, %rax
               	shlq	$0x3, %rax
               	leaq	(%rax,%rsi), %r9
               	movslq	%edx, %rdx
               	xorl	%eax, %eax
               	movq	%r9, %r13
               	shlq	%r13
               	addq	%rax, %r13
               	movslq	%r13d, %r13
               	movq	%rax, %r14
               	shlq	$0x3, %r14
               	shrxq	%r14, %rdx, %r14
               	andq	$0xff, %r14
               	movb	%r14b, (%rcx,%r13)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	incq	%r15
               	cmpl	$0x2, %r15d
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x3f, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x48(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x48(%rbp)
               	xorl	%r15d, %r15d
               	movl	$0x12, %eax
               	leaq	(%r15,%r15,2), %rcx
               	movslq	%ecx, %rcx
               	sarxq	%rcx, %rax, %rcx
               	movq	%r15, %rax
               	shlq	$0x4, %rax
               	movslq	%ecx, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x2, %rdx
               	andq	$0x1, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rax,%rdx), %rdi
               	andq	$0x3, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rax,%rcx), %r8
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rdi,%rsi), %rcx
               	addq	%rax, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%r12,%r9), %r9
               	subq	%r9, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movq	%r15, %rax
               	shlq	$0x3, %rax
               	leaq	(%rax,%rsi), %r9
               	movslq	%edx, %rdx
               	xorl	%eax, %eax
               	movq	%r9, %r13
               	shlq	%r13
               	addq	%rax, %r13
               	movslq	%r13d, %r13
               	movq	%rax, %r14
               	shlq	$0x3, %r14
               	shrxq	%r14, %rdx, %r14
               	andq	$0xff, %r14
               	movb	%r14b, (%rcx,%r13)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	incq	%r15
               	cmpl	$0x2, %r15d
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x12, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x48(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x48(%rbp)
               	xorl	%r15d, %r15d
               	movl	$0x38, %eax
               	leaq	(%r15,%r15,2), %rcx
               	movslq	%ecx, %rcx
               	sarxq	%rcx, %rax, %rcx
               	movq	%r15, %rax
               	shlq	$0x4, %rax
               	movslq	%ecx, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x2, %rdx
               	andq	$0x1, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rax,%rdx), %rdi
               	andq	$0x3, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rax,%rcx), %r8
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rdi,%rsi), %rcx
               	addq	%rax, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%r12,%r9), %r9
               	subq	%r9, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movq	%r15, %rax
               	shlq	$0x3, %rax
               	leaq	(%rax,%rsi), %r9
               	movslq	%edx, %rdx
               	xorl	%eax, %eax
               	movq	%r9, %r13
               	shlq	%r13
               	addq	%rax, %r13
               	movslq	%r13d, %r13
               	movq	%rax, %r14
               	shlq	$0x3, %r14
               	shrxq	%r14, %rdx, %r14
               	andq	$0xff, %r14
               	movb	%r14b, (%rcx,%r13)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	incq	%r15
               	cmpl	$0x2, %r15d
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x38, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, %r10
               	movq	-0x48(%rbp), %rax
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x40, %eax
               	leaq	-0x80(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<check_broadcasts>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	leaq	0x60(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%r12d, %r12d
               	movq	%r12, %r13
               	movl	$0x1, %eax
               	shlxq	%r12, %rax, %rsi
               	xorl	%r8d, %r8d
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %r8d
               	jge	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	leaq	-0x1(%rsi), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	imulq	$0x0, %rsi, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rbx,%rdi), %rdi
               	orq	%rdi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	movq	%rsi, %rdi
               	imulq	%r8, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdx,%rdi)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	incq	%r8
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %r8d
               	jl	<addr>
               	testl	%r12d, %r12d
               	jne	<addr>
               	movzbq	0x60(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	%al, 0x80(%rsp)
               	movb	%al, 0x81(%rsp)
               	movb	%al, 0x82(%rsp)
               	movb	%al, 0x83(%rsp)
               	movb	%al, 0x84(%rsp)
               	movb	%al, 0x85(%rsp)
               	movb	%al, 0x86(%rsp)
               	movb	%al, 0x87(%rsp)
               	movb	%al, 0x88(%rsp)
               	movb	%al, 0x89(%rsp)
               	movb	%al, 0x8a(%rsp)
               	movb	%al, 0x8b(%rsp)
               	movb	%al, 0x8c(%rsp)
               	movb	%al, 0x8d(%rsp)
               	movb	%al, 0x8e(%rsp)
               	movb	%al, 0x8f(%rsp)
               	leaq	0xa0(%rsp), %rax
               	movups	0x80(%rsp), %xmm0
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	cmpl	$0x1, %r12d
               	jne	<addr>
               	movzwq	0x60(%rsp), %rax
               	leaq	(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	%ax, (%rsp)
               	movw	%ax, 0x2(%rsp)
               	movw	%ax, 0x4(%rsp)
               	movw	%ax, 0x6(%rsp)
               	movw	%ax, 0x8(%rsp)
               	movw	%ax, 0xa(%rsp)
               	movw	%ax, 0xc(%rsp)
               	movw	%ax, 0xe(%rsp)
               	leaq	0xb0(%rsp), %rax
               	movups	(%rsp), %xmm0
               	movups	%xmm0, 0xb0(%rsp)
               	jmp	<addr>
               	cmpl	$0x2, %r12d
               	jne	<addr>
               	movl	0x60(%rsp), %eax
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	%eax, 0x20(%rsp)
               	movl	%eax, 0x24(%rsp)
               	movl	%eax, 0x28(%rsp)
               	movl	%eax, 0x2c(%rsp)
               	leaq	0xc0(%rsp), %rax
               	movups	0x20(%rsp), %xmm0
               	movups	%xmm0, 0xc0(%rsp)
               	jmp	<addr>
               	movq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rax, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	leaq	0xd0(%rsp), %rax
               	movups	0x40(%rsp), %xmm0
               	movups	%xmm0, 0xd0(%rsp)
               	leaq	0x70(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x90(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x14(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x1c(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	0x20(%rsp), %eax
               	leaq	0x40(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	%eax, 0x40(%rsp)
               	movl	%eax, 0x44(%rsp)
               	movl	%eax, 0x48(%rsp)
               	movl	%eax, 0x4c(%rsp)
               	movups	0x40(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	movl	0x20(%rsp), %eax
               	movl	%eax, 0x40(%rsp)
               	movl	%eax, 0x44(%rsp)
               	movl	%eax, 0x48(%rsp)
               	movl	%eax, 0x4c(%rsp)
               	movl	%eax, 0x50(%rsp)
               	movl	%eax, 0x54(%rsp)
               	movl	%eax, 0x58(%rsp)
               	movl	%eax, 0x5c(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rdx
               	movq	0x58(%rsp), %rsi
               	movq	%rax, (%rsp)
               	movq	%rcx, 0x8(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rsi, 0x18(%rsp)
               	leaq	0x80(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%r13, %r12
               	orq	%rcx, %r12
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rdx,%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x20(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rax, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	movups	0x40(%rsp), %xmm0
               	leaq	0x90(%rsp), %rdi
               	movups	%xmm0, 0x90(%rsp)
               	movq	0x20(%rsp), %rax
               	movq	%rax, 0x20(%rsp)
               	movq	%rax, 0x28(%rsp)
               	movq	%rax, 0x30(%rsp)
               	movq	%rax, 0x38(%rsp)
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %r12
               	leaq	-0x40(%rbp), %rsi
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x10(%rsi), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x60(%rsp), %rax
               	movq	0x68(%rsp), %rcx
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rax, 0x50(%rsp)
               	movq	%rcx, 0x58(%rsp)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%r12, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x160, %rsp            # imm = 0x160
               	andq	$-0x20, %rsp
               	xorl	%r10d, %r10d
               	movq	%r10, -0xc0(%rbp)
               	movq	-0xc0(%rbp), %r11
               	movq	%r11, -0xc8(%rbp)
               	leaq	-0xa0(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0xa0(%rbp), %r13
               	leaq	(%rsp), %rax
               	movups	(%r13), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r13), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	(%rsp), %r14
               	movq	0x8(%rsp), %r15
               	movq	0x10(%rsp), %r10
               	movq	%r10, -0xa8(%rbp)
               	movq	0x18(%rsp), %r10
               	movq	%r10, -0xb0(%rbp)
               	xorl	%r12d, %r12d
               	movq	%r12, -0xb8(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%r12,4), %rbx
               	movl	$0x20, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%r13, %rdi
               	movq	%rbx, %r8
               	callq	<addr>
               	leaq	0x140(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r14, 0x140(%rsp)
               	movq	%r15, 0x148(%rsp)
               	movups	0x140(%rsp), %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x50(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	movq	%rbx, %xmm14
               	psllw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x150(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	-0xa8(%rbp), %r10
               	movq	%r10, 0x150(%rsp)
               	movq	-0xb0(%rbp), %r10
               	movq	%r10, 0x158(%rsp)
               	movups	0x150(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x60(%rsp), %rax
               	leaq	0x70(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	movq	%rbx, %xmm14
               	psllw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movq	0x50(%rsp), %rax
               	movq	0x58(%rsp), %rcx
               	movq	0x70(%rsp), %rdx
               	movq	0x78(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movq	%rax, 0x20(%rsp)
               	movq	%rcx, 0x28(%rsp)
               	movq	%rdx, 0x30(%rsp)
               	movq	%rdi, 0x38(%rsp)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0xb8(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0xb8(%rbp)
               	movl	$0x20, %esi
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%r13, %rdi
               	movq	%rbx, %r8
               	callq	<addr>
               	leaq	0x140(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r14, 0x140(%rsp)
               	movq	%r15, 0x148(%rsp)
               	movups	0x140(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x80(%rsp), %rax
               	leaq	0x90(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	movq	%rbx, %xmm14
               	psrlw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x150(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	-0xa8(%rbp), %r10
               	movq	%r10, 0x150(%rsp)
               	movq	-0xb0(%rbp), %r10
               	movq	%r10, 0x158(%rsp)
               	movups	0x150(%rsp), %xmm0
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	movq	%rbx, %xmm14
               	psrlw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movq	0x90(%rsp), %rax
               	movq	0x98(%rsp), %rcx
               	movq	0xb0(%rsp), %rdx
               	movq	0xb8(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movq	%rax, 0x20(%rsp)
               	movq	%rcx, 0x28(%rsp)
               	movq	%rdx, 0x30(%rsp)
               	movq	%rdi, 0x38(%rsp)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0xb8(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0xb8(%rbp)
               	movl	$0x20, %esi
               	movl	$0x2, %edx
               	leaq	-0x40(%rbp), %r9
               	movq	%r13, %rdi
               	movq	%rbx, %r8
               	movq	%rdx, %rcx
               	callq	<addr>
               	leaq	0x140(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r14, 0x140(%rsp)
               	movq	%r15, 0x148(%rsp)
               	movups	0x140(%rsp), %xmm0
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0xd0(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	movq	%rbx, %xmm14
               	psraw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x150(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	-0xa8(%rbp), %r10
               	movq	%r10, 0x150(%rsp)
               	movq	-0xb0(%rbp), %r10
               	movq	%r10, 0x158(%rsp)
               	movups	0x150(%rsp), %xmm0
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0xe0(%rsp), %rax
               	leaq	0xf0(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	movq	%rbx, %xmm14
               	psraw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movq	0xd0(%rsp), %rax
               	movq	0xd8(%rsp), %rcx
               	movq	0xf0(%rsp), %rdx
               	movq	0xf8(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movq	%rax, 0x20(%rsp)
               	movq	%rcx, 0x28(%rsp)
               	movq	%rdx, 0x30(%rsp)
               	movq	%rdi, 0x38(%rsp)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0xb8(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0xb8(%rbp)
               	movl	$0x20, %esi
               	movl	$0x4, %edx
               	movl	$0x2, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%r13, %rdi
               	movq	%rbx, %r8
               	callq	<addr>
               	leaq	0x140(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r14, 0x140(%rsp)
               	movq	%r15, 0x148(%rsp)
               	movups	0x140(%rsp), %xmm0
               	movups	%xmm0, 0x100(%rsp)
               	leaq	0x100(%rsp), %rax
               	leaq	0x110(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	movq	%rbx, %xmm14
               	psrad	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x150(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	-0xa8(%rbp), %r10
               	movq	%r10, 0x150(%rsp)
               	movq	-0xb0(%rbp), %r10
               	movq	%r10, 0x158(%rsp)
               	movups	0x150(%rsp), %xmm0
               	movups	%xmm0, 0x120(%rsp)
               	leaq	0x120(%rsp), %rax
               	leaq	0x130(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	movq	%rbx, %xmm14
               	psrad	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movq	0x110(%rsp), %rax
               	movq	0x118(%rsp), %rcx
               	movq	0x130(%rsp), %rdx
               	movq	0x138(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movq	%rax, 0x20(%rsp)
               	movq	%rcx, 0x28(%rsp)
               	movq	%rdx, 0x30(%rsp)
               	movq	%rdi, 0x38(%rsp)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0xb8(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0xb8(%rbp)
               	incq	%r12
               	cmpl	$0xb, %r12d
               	jb	<addr>
               	movq	-0xb8(%rbp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	movq	-0xc8(%rbp), %rbx
               	orq	%rax, %rbx
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0xa0(%rbp), %rdi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	leaq	-0x60(%rbp), %rdx
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0xa0(%rbp), %rdi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0xa0(%rbp), %rdi
               	callq	<addr>
               	movq	%rbx, %r10
               	orq	%rax, %r10
               	movq	%r10, -0xc8(%rbp)
               	movq	-0xc0(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0xc0(%rbp)
               	movq	-0xc0(%rbp), %rax
               	cmpl	$0xc8, %eax
               	jl	<addr>
               	movq	-0xc8(%rbp), %rax
               	leaq	-0x100(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq


avx2_lanes_and_low_lane_transfers_follow_the_sdm.x64:	file format elf64-x86-64

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

<check_moves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movups	(%rbx), %xmm1
               	movups	0x10(%rbx), %xmm2
               	vpextrb	$0x0, %xmm1, %eax
               	movsbq	%al, %rax
               	movsbq	%al, %rax
               	andq	$0xff, %rax
               	vmovd	%eax, %xmm0
               	vpbroadcastb	%xmm0, %ymm0
               	vmovups	%ymm0, (%rsp)
               	vpextrw	$0x0, %xmm1, %eax
               	movswq	%ax, %rax
               	movswq	%ax, %rax
               	vmovd	%eax, %xmm0
               	vpbroadcastw	%xmm0, %ymm0
               	vmovups	%ymm0, 0x20(%rsp)
               	vmovd	%xmm1, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm0
               	vpbroadcastd	%xmm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm0
               	vpbroadcastq	%xmm0, %ymm0
               	vmovups	%ymm0, 0x60(%rsp)
               	xorl	%r14d, %r14d
               	movl	$0x1, %eax
               	shlxq	%r14, %rax, %rcx
               	leaq	(%rsp), %rax
               	movq	%r14, %rdx
               	shlq	$0x5, %rdx
               	addq	%rdx, %rax
               	vmovups	(%rax), %ymm0
               	vmovups	%ymm0, -0x20(%rbp)
               	xorl	%r13d, %r13d
               	imulq	$0x0, %rcx, %rdi
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r13d
               	jge	<addr>
               	movq	%rcx, %r8
               	imulq	%r13, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	(%r8,%rax), %r9
               	movslq	%r9d, %r9
               	movzbq	-0x20(%rbp,%r9), %r9
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	movslq	%r12d, %r12
               	shlxq	%r12, %r9, %r9
               	orq	%r9, %rdx
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	(%rdi,%rax), %r8
               	movslq	%r8d, %r8
               	movzbq	(%rbx,%r8), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shlxq	%r9, %r8, %r8
               	orq	%r8, %rsi
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	incq	%r13
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r13d
               	jl	<addr>
               	incq	%r14
               	cmpl	$0x4, %r14d
               	jl	<addr>
               	vmovdqa	%xmm1, %xmm0
               	vinserti128	$0x1, %xmm2, %ymm0, %ymm0
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	vmovups	%ymm0, -0x40(%rbp)
               	movq	%rbx, %rsi
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	vmovups	-0x40(%rbp), %ymm0
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
               	vmovdqa	%xmm0, %xmm1
               	leaq	(%rsp), %rdi
               	movups	%xmm1, (%rsp)
               	vextracti128	$0x1, %ymm0, %xmm0
               	movups	%xmm0, 0x10(%rsp)
               	movl	$0x10, %edx
               	movq	%rbx, %rsi
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movl	$0x10, %edx
               	leaq	0x10(%rax), %rdi
               	leaq	0x10(%rbx), %rsi
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
               	xorl	%eax, %eax
               	vmovq	%rax, %xmm14
               	vmovups	%ymm14, -0x20(%rbp)
               	cmpb	$0x0, -0x20(%rbp,%rax)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	vmovd	%r11d, %xmm0
               	vpbroadcastd	%xmm0, %ymm0
               	vmovups	%ymm0, -0x20(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	0x1c(%rax), %rsi
               	movzbq	-0x20(%rbp,%rsi), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rcx
               	movl	$0x1, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movzbq	-0x20(%rbp,%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq

<check_low_lane>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r14
               	leaq	0x1(%r14), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x8(%rbp), %xmm0
               	xorl	%eax, %eax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	leaq	0x3(%r14), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x8(%rbp), %edx
               	vmovd	%edx, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movups	%xmm0, -0x40(%rbp)
               	leaq	0x5(%r14), %rdx
               	movzwq	(%rdx), %r10
               	movw	%r10w, (%rcx)
               	movswq	-0x8(%rbp), %rcx
               	vpinsrw	$0x0, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x1, %eax, %xmm0, %xmm0
               	vpinsrw	$0x2, %eax, %xmm0, %xmm0
               	vpinsrw	$0x3, %eax, %xmm0, %xmm0
               	vpinsrw	$0x4, %eax, %xmm0, %xmm0
               	vpinsrw	$0x5, %eax, %xmm0, %xmm0
               	vpinsrw	$0x6, %eax, %xmm0, %xmm0
               	vpinsrw	$0x7, %eax, %xmm0, %xmm0
               	movups	%xmm0, -0x30(%rbp)
               	xorl	%ebx, %ebx
               	leaq	0x1(%r14), %r13
               	movl	$0x8, %eax
               	sarxq	%rbx, %rax, %r12
               	leaq	-0x18(%rbp), %rdi
               	leaq	-0x50(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	movups	(%rax), %xmm0
               	movups	%xmm0, -0x18(%rbp)
               	movq	%rbx, %rax
               	shlq	%rax
               	leaq	(%r13,%rax), %rsi
               	movslq	%r12d, %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	%r12d, %rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	cmpb	$0x0, -0x18(%rbp,%rax)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x3, %ebx
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movabsq	$-0x5555555555555556, %rcx # imm = 0xAAAAAAAAAAAAAAAA
               	movq	%rcx, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	leaq	0x1(%rax), %rdx
               	movups	-0x50(%rbp), %xmm0
               	vmovq	%xmm0, %rcx
               	movq	%rcx, -0x20(%rbp)
               	movq	%rcx, (%rdx)
               	leaq	0xb(%rax), %rdx
               	movups	-0x40(%rbp), %xmm0
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	movl	%ecx, -0x20(%rbp)
               	movl	%ecx, (%rdx)
               	leaq	0x11(%rax), %rcx
               	movups	-0x30(%rbp), %xmm0
               	vpextrw	$0x0, %xmm0, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x20(%rbp)
               	movw	%ax, (%rcx)
               	leaq	-0x18(%rbp), %rax
               	leaq	0x1(%rax), %rdi
               	leaq	0x1(%r14), %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	-0x18(%rbp), %rax
               	cmpl	$0xaa, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	-0xf(%rbp), %rax
               	cmpl	$0xaa, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	0xb(%rax), %rdi
               	leaq	0x3(%r14), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	-0x9(%rbp), %rcx
               	cmpl	$0xaa, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	0x11(%rax), %rdi
               	leaq	0x5(%r14), %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	-0x5(%rbp), %rax
               	cmpl	$0xaa, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<find16>:
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	vmovd	%esi, %xmm0
               	vpextrw	$0x0, %xmm0, %eax
               	movswq	%ax, %rax
               	movswq	%ax, %rax
               	vmovd	%eax, %xmm0
               	vpbroadcastw	%xmm0, %ymm0
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rcx
               	movq	%rax, %rdx
               	shlq	%rdx
               	addq	%rdi, %rdx
               	vmovups	(%rdx), %ymm1
               	vpcmpeqw	%ymm0, %ymm1, %ymm1
               	vpmovmskb	%ymm1, %edx
               	testl	%edx, %edx
               	jne	<addr>
               	movq	%rcx, %rax
               	leaq	0x10(%rax), %rcx
               	cmpl	$0x28, %ecx
               	jbe	<addr>
               	cmpl	$0x28, %eax
               	jae	<addr>
               	movzwq	(%rdi,%rax,2), %rcx
               	cmpl	%esi, %ecx
               	je	<addr>
               	incq	%rax
               	cmpl	$0x28, %eax
               	jb	<addr>
               	xorl	%eax, %eax
               	vzeroupper
               	retq
               	shlq	%rax
               	addq	%rdi, %rax
               	vzeroupper
               	retq
               	shlq	%rax
               	addq	%rdi, %rax
               	movl	$0x20, %r11d
               	bsfl	%edx, %ecx
               	cmovel	%r11d, %ecx
               	sarq	%rcx
               	shlq	%rcx
               	addq	%rcx, %rax
               	vzeroupper
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x200, %rsp            # imm = 0x200
               	andq	$-0x20, %rsp
               	xorl	%r10d, %r10d
               	movq	%r10, -0xc0(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, -0xb0(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
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
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, -0x90(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
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
               	jmp	<addr>
               	movq	-0xc0(%rbp), %rax
               	testb	$0x1, %al
               	je	<addr>
               	leaq	-0x90(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	-0xb0(%rbp), %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	vmovups	-0xb0(%rbp), %ymm0
               	vmovups	-0x90(%rbp), %ymm1
               	vpaddb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	vpaddw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rsp)
               	vpaddd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rsp)
               	vpaddq	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x60(%rsp)
               	vpsubb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x80(%rsp)
               	vpsubw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0xa0(%rsp)
               	vpsubd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0xc0(%rsp)
               	vpsubq	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0xe0(%rsp)
               	vpcmpeqb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x100(%rsp)
               	vpcmpeqw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x120(%rsp)
               	vpcmpeqd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x140(%rsp)
               	vpcmpeqq	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x160(%rsp)
               	xorl	%r15d, %r15d
               	movl	$0x1, %eax
               	movq	%r15, %rcx
               	andq	$0x3, %rcx
               	shlxq	%rcx, %rax, %rcx
               	leaq	(%rsp), %rax
               	movq	%r15, %rdx
               	shlq	$0x5, %rdx
               	addq	%rdx, %rax
               	vmovups	(%rax), %ymm2
               	vmovups	%ymm2, -0x70(%rbp)
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	movslq	%eax, %r10
               	movq	%r10, -0xb8(%rbp)
               	xorl	%r13d, %r13d
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r13d
               	jge	<addr>
               	movq	%rcx, %rsi
               	imulq	%r13, %rsi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	(%rsi,%rax), %r9
               	movslq	%r9d, %r9
               	movzbq	-0xb0(%rbp,%r9), %r9
               	movq	%rax, %rbx
               	shlq	$0x3, %rbx
               	movslq	%ebx, %rbx
               	shlxq	%rbx, %r9, %r9
               	orq	%r9, %rdx
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rcx, %r9
               	imulq	%r13, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	(%r9,%rax), %rbx
               	movslq	%ebx, %rbx
               	movzbq	-0x90(%rbp,%rbx), %rbx
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	movslq	%r12d, %r12
               	shlxq	%r12, %rbx, %rbx
               	orq	%rbx, %rsi
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpl	$0x4, %r15d
               	jge	<addr>
               	leaq	(%rdx,%rsi), %r14
               	movq	%rcx, %r9
               	imulq	%r13, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	(%r9,%rax), %rbx
               	movslq	%ebx, %rbx
               	movzbq	-0x70(%rbp,%rbx), %rbx
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	movslq	%r12d, %r12
               	shlxq	%r12, %rbx, %rbx
               	orq	%rbx, %rdx
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movq	$-0x1, %rax
               	andq	%r14, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	-0xb8(%rbp), %r10
               	shlxq	%r10, %rax, %rax
               	decq	%rax
               	jmp	<addr>
               	cmpl	$0x8, %r15d
               	jge	<addr>
               	movq	%rdx, %r14
               	subq	%rsi, %r14
               	jmp	<addr>
               	movq	$-0x1, %r14
               	xorl	%eax, %eax
               	cmpq	%rsi, %rdx
               	cmovneq	%rax, %r14
               	jmp	<addr>
               	incq	%r13
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r13d
               	jl	<addr>
               	incq	%r15
               	cmpl	$0xc, %r15d
               	jl	<addr>
               	vpand	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x180(%rsp)
               	vpandn	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x1a0(%rsp)
               	vpor	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x1c0(%rsp)
               	vpxor	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x1e0(%rsp)
               	xorl	%edx, %edx
               	leaq	0x180(%rsp), %rax
               	movq	%rdx, %rcx
               	shlq	$0x5, %rcx
               	addq	%rcx, %rax
               	vmovups	(%rax), %ymm2
               	vmovups	%ymm2, -0x20(%rbp)
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	-0xb0(%rbp,%rax), %rcx
               	movzbq	-0x90(%rbp,%rax), %r9
               	andq	%r9, %rcx
               	movzbq	-0x20(%rbp,%rax), %r9
               	cmpl	%ecx, %r9d
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movzbq	-0xb0(%rbp,%rax), %rcx
               	xorq	$-0x1, %rcx
               	andq	$0xff, %rcx
               	movzbq	-0x90(%rbp,%rax), %r9
               	andq	%r9, %rcx
               	jmp	<addr>
               	cmpl	$0x2, %edx
               	jne	<addr>
               	movzbq	-0xb0(%rbp,%rax), %rcx
               	movzbq	-0x90(%rbp,%rax), %r9
               	orq	%r9, %rcx
               	jmp	<addr>
               	movzbq	-0xb0(%rbp,%rax), %rcx
               	movzbq	-0x90(%rbp,%rax), %r9
               	xorq	%r9, %rcx
               	movzbq	-0x20(%rbp,%rax), %r9
               	cmpl	%ecx, %r9d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x4, %edx
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movzbq	-0xb0(%rbp,%rax), %rdx
               	shrq	$0x7, %rdx
               	shlxq	%rax, %rdx, %rdx
               	orq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	vpmovmskb	%ymm0, %eax
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	movzbq	-0xb0(%rbp,%rax), %rdx
               	movzbq	-0x90(%rbp,%rax), %rsi
               	andq	%rsi, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	vpand	%ymm1, %ymm0, %ymm0
               	vmovq	%xmm0, %rax
               	vpextrq	$0x1, %xmm0, %rdx
               	orq	%rdx, %rax
               	vextracti128	$0x1, %ymm0, %xmm1
               	vmovq	%xmm1, %rdx
               	orq	%rdx, %rax
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rdi
               	vzeroupper
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rdi
               	vzeroupper
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	addq	$0x1, -0xc0(%rbp)
               	movq	-0xc0(%rbp), %rax
               	cmpl	$0xc8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	0x100(%rax), %rdx
               	movw	%dx, -0x50(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x115, %esi            # imm = 0x115
               	movl	$0x28, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	0x2a(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xaf, %eax
               	leaq	-0xf0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x127, %esi            # imm = 0x127
               	movl	$0x28, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	0x4e(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb0, %eax
               	leaq	-0xf0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x21, %esi
               	movl	$0x28, %edx
               	vzeroupper
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb1, %eax
               	leaq	-0xf0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0xf0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0xaa, %eax
               	leaq	-0xf0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0xa9, %eax
               	leaq	-0xf0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0xa8, %eax
               	leaq	-0xf0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq

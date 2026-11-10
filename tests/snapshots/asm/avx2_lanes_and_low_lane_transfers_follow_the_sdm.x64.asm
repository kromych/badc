
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

<check_lanes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x180, %rsp            # imm = 0x180
               	andq	$-0x20, %rsp
               	vmovups	(%rdi), %ymm0
               	vmovups	(%rsi), %ymm1
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	movups	%xmm14, 0x80(%rax)
               	movups	%xmm14, 0x90(%rax)
               	movups	%xmm14, 0xa0(%rax)
               	movups	%xmm14, 0xb0(%rax)
               	movups	%xmm14, 0xc0(%rax)
               	movups	%xmm14, 0xd0(%rax)
               	movups	%xmm14, 0xe0(%rax)
               	movups	%xmm14, 0xf0(%rax)
               	movups	%xmm14, 0x100(%rax)
               	movups	%xmm14, 0x110(%rax)
               	movups	%xmm14, 0x120(%rax)
               	movups	%xmm14, 0x130(%rax)
               	movups	%xmm14, 0x140(%rax)
               	movups	%xmm14, 0x150(%rax)
               	movups	%xmm14, 0x160(%rax)
               	movups	%xmm14, 0x170(%rax)
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
               	xorl	%r14d, %r14d
               	movl	$0x1, %eax
               	movq	%r14, %rcx
               	andq	$0x3, %rcx
               	shlxq	%rcx, %rax, %rcx
               	leaq	-0x20(%rbp), %rax
               	leaq	(%rsp), %rdx
               	movq	%r14, %r8
               	shlq	$0x5, %r8
               	addq	%r8, %rdx
               	vmovups	(%rdx), %ymm2
               	vmovups	%ymm2, (%rax)
               	xorl	%r8d, %r8d
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %r9
               	imulq	%r8, %r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movzbq	(%rdi,%r9), %r9
               	movq	%rax, %rbx
               	shlq	$0x3, %rbx
               	movslq	%ebx, %rbx
               	shlxq	%rbx, %r9, %r9
               	orq	%r9, %rdx
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %r9
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rbx
               	imulq	%r8, %rbx
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rsi,%rbx), %rbx
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	movslq	%r12d, %r12
               	shlxq	%r12, %rbx, %rbx
               	orq	%rbx, %r9
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpl	$0x4, %r14d
               	jge	<addr>
               	leaq	(%rdx,%r9), %r13
               	leaq	-0x20(%rbp), %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rbx
               	imulq	%r8, %rbx
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%r9,%rbx), %rbx
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
               	andq	%r13, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rcx, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shlxq	%r9, %rax, %rax
               	decq	%rax
               	jmp	<addr>
               	cmpl	$0x8, %r14d
               	jge	<addr>
               	movq	%rdx, %r13
               	subq	%r9, %r13
               	jmp	<addr>
               	cmpq	%r9, %rdx
               	jne	<addr>
               	movq	$-0x1, %r13
               	jmp	<addr>
               	xorl	%r13d, %r13d
               	jmp	<addr>
               	incq	%r8
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
               	jl	<addr>
               	incq	%r14
               	cmpl	$0xc, %r14d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	vpand	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	vpandn	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rsp)
               	vpor	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rsp)
               	vpxor	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x60(%rsp)
               	xorl	%edx, %edx
               	leaq	-0x20(%rbp), %r8
               	leaq	(%rsp), %rax
               	movq	%rdx, %rcx
               	shlq	$0x5, %rcx
               	addq	%rcx, %rax
               	vmovups	(%rax), %ymm2
               	vmovups	%ymm2, (%r8)
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%rsi,%rax), %r9
               	andq	%r9, %rcx
               	movzbq	(%r8,%rax), %r9
               	cmpl	%ecx, %r9d
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movzbq	(%rdi,%rax), %rcx
               	xorq	$-0x1, %rcx
               	andq	$0xff, %rcx
               	movzbq	(%rsi,%rax), %r9
               	andq	%r9, %rcx
               	jmp	<addr>
               	cmpl	$0x2, %edx
               	jne	<addr>
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%rsi,%rax), %r9
               	orq	%r9, %rcx
               	jmp	<addr>
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%rsi,%rax), %r9
               	xorq	%r9, %rcx
               	movzbq	(%r8,%rax), %r9
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
               	movzbq	(%rdi,%rax), %rdx
               	shrq	$0x7, %rdx
               	shlxq	%rax, %rdx, %rdx
               	orq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	vpmovmskb	%ymm0, %eax
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%rsi,%rax), %r8
               	andq	%r8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	vpand	%ymm1, %ymm0, %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rax
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rdx
               	orq	%rdx, %rax
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rdx
               	orq	%rdx, %rax
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	%ecx, %eax
               	setne	%al
               	movzbq	%al, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq

<check_moves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movups	(%rbx), %xmm1
               	movups	0x10(%rbx), %xmm2
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	vpextrb	$0x0, %xmm1, %eax
               	movsbq	%al, %rax
               	movsbq	%al, %rax
               	andq	$0xff, %rax
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
               	movb	%al, 0x90(%rsp)
               	movb	%al, 0x91(%rsp)
               	movb	%al, 0x92(%rsp)
               	movb	%al, 0x93(%rsp)
               	movb	%al, 0x94(%rsp)
               	movb	%al, 0x95(%rsp)
               	movb	%al, 0x96(%rsp)
               	movb	%al, 0x97(%rsp)
               	movb	%al, 0x98(%rsp)
               	movb	%al, 0x99(%rsp)
               	movb	%al, 0x9a(%rsp)
               	movb	%al, 0x9b(%rsp)
               	movb	%al, 0x9c(%rsp)
               	movb	%al, 0x9d(%rsp)
               	movb	%al, 0x9e(%rsp)
               	movb	%al, 0x9f(%rsp)
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	movq	0x90(%rsp), %rdx
               	movq	0x98(%rsp), %rsi
               	movq	%rax, (%rsp)
               	movq	%rcx, 0x8(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rsi, 0x18(%rsp)
               	vpextrw	$0x0, %xmm1, %eax
               	movswq	%ax, %rax
               	movw	%ax, 0x80(%rsp)
               	movw	%ax, 0x82(%rsp)
               	movw	%ax, 0x84(%rsp)
               	movw	%ax, 0x86(%rsp)
               	movw	%ax, 0x88(%rsp)
               	movw	%ax, 0x8a(%rsp)
               	movw	%ax, 0x8c(%rsp)
               	movw	%ax, 0x8e(%rsp)
               	movw	%ax, 0x90(%rsp)
               	movw	%ax, 0x92(%rsp)
               	movw	%ax, 0x94(%rsp)
               	movw	%ax, 0x96(%rsp)
               	movw	%ax, 0x98(%rsp)
               	movw	%ax, 0x9a(%rsp)
               	movw	%ax, 0x9c(%rsp)
               	movw	%ax, 0x9e(%rsp)
               	movq	0x80(%rsp), %rdx
               	movq	0x88(%rsp), %rsi
               	movq	0x90(%rsp), %rdi
               	movq	0x98(%rsp), %r8
               	leaq	(%rsp), %rcx
               	leaq	0x20(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	vpextrd	$0x0, %xmm1, %eax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	xorl	%edx, %edx
               	vmovd	%eax, %xmm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrd	$0x1, %eax, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrd	$0x2, %eax, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrd	$0x3, %eax, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrd	$0x0, %eax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrd	$0x1, %eax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrd	$0x2, %eax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vmovaps	%ymm0, %ymm14
               	vextracti128	$0x1, %ymm14, %xmm15
               	vpinsrd	$0x3, %eax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x70(%rbp)
               	vmovups	-0x70(%rbp), %ymm14
               	vmovups	%ymm14, 0x40(%rsp)
               	vpextrq	$0x0, %xmm1, %rax
               	addq	$0x60, %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, 0x10(%rcx)
               	movq	%rax, 0x18(%rcx)
               	xorl	%r12d, %r12d
               	movl	$0x1, %eax
               	shlxq	%r12, %rax, %rcx
               	leaq	-0x50(%rbp), %rax
               	leaq	(%rsp), %rdx
               	movq	%r12, %rsi
               	shlq	$0x5, %rsi
               	addq	%rsi, %rdx
               	vmovups	(%rdx), %ymm0
               	vmovups	%ymm0, (%rax)
               	xorl	%r8d, %r8d
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
               	jge	<addr>
               	leaq	-0x50(%rbp), %rsi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%r8, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rsi,%rdi), %rdi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shlxq	%r9, %rdi, %rdi
               	orq	%rdi, %rdx
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	cmpl	%ecx, %eax
               	jge	<addr>
               	imulq	$0x0, %rcx, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rbx,%rdi), %rdi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shlxq	%r9, %rdi, %rdi
               	orq	%rdi, %rsi
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	incq	%r8
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
               	jl	<addr>
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	vpextrq	$0x0, %xmm1, %r12
               	vmovq	%r12, %xmm0
               	vpextrq	$0x1, %xmm1, %r13
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrq	$0x1, %r13, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrq	$0x0, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrq	$0x1, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vpextrq	$0x0, %xmm2, %r14
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrq	$0x0, %r14, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vpextrq	$0x1, %xmm2, %r15
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrq	$0x1, %r15, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	leaq	-0x50(%rbp), %rdi
               	vmovups	%ymm0, (%rdi)
               	movl	$0x20, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r12, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	movups	(%rsp), %xmm0
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r14, (%rsp)
               	movq	%r15, 0x8(%rsp)
               	movups	(%rsp), %xmm0
               	movups	%xmm0, 0xb0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	movl	$0x10, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0xa0(%rsp), %rax
               	movl	$0x10, %edx
               	leaq	0x10(%rax), %rdi
               	leaq	0x10(%rbx), %rsi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	leaq	-0x50(%rbp), %rcx
               	xorl	%eax, %eax
               	vmovq	%rax, %xmm14
               	vmovups	%ymm14, (%rcx)
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdx
               	movq	$-0x2, %rax
               	vmovups	-0x70(%rbp), %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrd	$0x0, %eax, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrd	$0x1, %eax, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrd	$0x2, %eax, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrd	$0x3, %eax, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrd	$0x0, %eax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrd	$0x1, %eax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrd	$0x2, %eax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrd	$0x3, %eax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vmovups	%ymm0, (%rdx)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	0x1c(%rax), %rsi
               	movzbq	(%rdx,%rsi), %rsi
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
               	leaq	-0x50(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movzbq	(%rdx,%rax), %rsi
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
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq

<find16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%esi, -0x10(%rbp)
               	xorl	%eax, %eax
               	movl	%eax, -0xc(%rbp)
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, -0x4(%rbp)
               	movzwq	-0x10(%rbp), %rcx
               	movswq	%cx, %rcx
               	xorl	%edx, %edx
               	vmovq	%rdx, %xmm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrw	$0x0, %ecx, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrw	$0x1, %ecx, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrw	$0x2, %ecx, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrw	$0x3, %ecx, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrw	$0x4, %ecx, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrw	$0x5, %ecx, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrw	$0x6, %ecx, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpinsrw	$0x7, %ecx, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrw	$0x0, %ecx, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrw	$0x1, %ecx, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrw	$0x2, %ecx, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrw	$0x3, %ecx, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrw	$0x4, %ecx, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrw	$0x5, %ecx, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrw	$0x6, %ecx, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrw	$0x7, %ecx, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
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
               	leave
               	retq
               	shlq	%rax
               	addq	%rdi, %rax
               	vzeroupper
               	leave
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
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r14d, %r14d
               	leaq	-0x90(%rbp), %rdx
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
               	leaq	-0x70(%rbp), %rdx
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
               	testb	$0x1, %r14b
               	je	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	-0x90(%rbp), %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x90(%rbp), %rdi
               	leaq	-0x70(%rbp), %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x90(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x90(%rbp), %r13
               	leaq	-0x100(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	0x1(%r13), %rax
               	leaq	-0xd0(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	movq	-0xd0(%rbp), %rcx
               	vmovq	%rcx, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movups	%xmm0, -0x100(%rbp)
               	leaq	0x3(%r13), %rcx
               	leaq	-0xc8(%rbp), %rdx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rdx)
               	movslq	-0xc8(%rbp), %rcx
               	vmovd	%ecx, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movups	%xmm0, -0xf0(%rbp)
               	leaq	0x5(%r13), %rax
               	leaq	-0xc0(%rbp), %rcx
               	movzwq	(%rax), %r10
               	movw	%r10w, (%rcx)
               	xorl	%r12d, %r12d
               	movswq	-0xc0(%rbp), %rax
               	movq	%r12, %xmm0
               	vpinsrw	$0x0, %eax, %xmm0, %xmm0
               	vpinsrw	$0x1, %r12d, %xmm0, %xmm0
               	vpinsrw	$0x2, %r12d, %xmm0, %xmm0
               	vpinsrw	$0x3, %r12d, %xmm0, %xmm0
               	vpinsrw	$0x4, %r12d, %xmm0, %xmm0
               	vpinsrw	$0x5, %r12d, %xmm0, %xmm0
               	vpinsrw	$0x6, %r12d, %xmm0, %xmm0
               	vpinsrw	$0x7, %r12d, %xmm0, %xmm0
               	movups	%xmm0, -0xe0(%rbp)
               	movl	$0x8, %eax
               	sarxq	%r12, %rax, %rbx
               	leaq	-0xa8(%rbp), %rdi
               	leaq	-0x100(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	movups	(%rax), %xmm0
               	movups	%xmm0, (%rdi)
               	leaq	0x1(%r13), %rax
               	movq	%r12, %rcx
               	shlq	%rcx
               	leaq	(%rax,%rcx), %rsi
               	movslq	%ebx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x10, %ebx
               	jge	<addr>
               	leaq	-0xa8(%rbp), %rax
               	movslq	%ebx, %rcx
               	cmpb	$0x0, (%rax,%rcx)
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x10, %ebx
               	jl	<addr>
               	incq	%r12
               	cmpl	$0x3, %r12d
               	jl	<addr>
               	leaq	-0xa8(%rbp), %rcx
               	movb	$-0x56, -0xa8(%rbp)
               	movb	$-0x56, -0xa7(%rbp)
               	movb	$-0x56, -0xa6(%rbp)
               	movb	$-0x56, -0xa5(%rbp)
               	movb	$-0x56, -0xa4(%rbp)
               	movb	$-0x56, -0xa3(%rbp)
               	movb	$-0x56, -0xa2(%rbp)
               	movb	$-0x56, -0xa1(%rbp)
               	movb	$-0x56, -0xa0(%rbp)
               	movb	$-0x56, -0x9f(%rbp)
               	movb	$-0x56, -0x9e(%rbp)
               	movb	$-0x56, -0x9d(%rbp)
               	movb	$-0x56, -0x9c(%rbp)
               	movb	$-0x56, -0x9b(%rbp)
               	movb	$-0x56, -0x9a(%rbp)
               	movb	$-0x56, -0x99(%rbp)
               	movb	$-0x56, -0x98(%rbp)
               	movb	$-0x56, -0x97(%rbp)
               	movb	$-0x56, -0x96(%rbp)
               	movb	$-0x56, -0x95(%rbp)
               	movb	$-0x56, -0x94(%rbp)
               	movb	$-0x56, -0x93(%rbp)
               	movb	$-0x56, -0x92(%rbp)
               	movb	$-0x56, -0x91(%rbp)
               	leaq	0x1(%rcx), %rax
               	movq	-0x100(%rbp), %rdx
               	movq	%rdx, -0xb8(%rbp)
               	leaq	-0xb8(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	leaq	0xb(%rcx), %rax
               	movl	-0xf0(%rbp), %edx
               	movl	%edx, -0xb0(%rbp)
               	leaq	-0xb0(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rax)
               	leaq	0x11(%rcx), %rax
               	movzwq	-0xe0(%rbp), %rcx
               	movswq	%cx, %rcx
               	movw	%cx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	leaq	-0xa8(%rbp), %rax
               	leaq	0x1(%rax), %rdi
               	leaq	0x1(%r13), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa8(%rbp), %rax
               	movzbq	-0xa8(%rbp), %rcx
               	cmpl	$0xaa, %ecx
               	jne	<addr>
               	movzbq	-0x9f(%rbp), %rcx
               	cmpl	$0xaa, %ecx
               	jne	<addr>
               	leaq	0xb(%rax), %rdi
               	leaq	0x3(%r13), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa8(%rbp), %rax
               	movzbq	-0x99(%rbp), %rcx
               	cmpl	$0xaa, %ecx
               	jne	<addr>
               	leaq	0x11(%rax), %rdi
               	leaq	0x5(%r13), %rsi
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	-0x95(%rbp), %rax
               	cmpl	$0xaa, %eax
               	jne	<addr>
               	incq	%r14
               	cmpl	$0xc8, %r14d
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rcx
               	leaq	0x100(%rax), %rdx
               	movw	%dx, (%rcx,%rax,2)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x115, %esi            # imm = 0x115
               	movl	$0x28, %edx
               	callq	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	0x2a(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xaf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x127, %esi            # imm = 0x127
               	movl	$0x28, %edx
               	callq	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	0x4e(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb0, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x21, %esi
               	movl	$0x28, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0xaa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0xa9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0xa8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq


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
               	xorl	%r8d, %r8d
               	vmovq	%rax, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	vmovq	%rax, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	movups	%xmm0, 0x40(%rsp)
               	movups	%xmm1, 0x50(%rsp)
               	movq	%r13, %rax
               	sarq	$0x2, %rax
               	andq	$0x1, %rax
               	movq	%rax, %r9
               	shlq	$0x2, %r9
               	movq	%r13, %rax
               	andq	$0x3, %rax
               	shlq	$0x2, %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdi
               	leaq	0x40(%rsp), %rdx
               	leaq	(%r9,%r8), %rsi
               	addq	%rcx, %rsi
               	movsbq	(%rdx,%rsi), %rdx
               	andq	$0xff, %rdx
               	leaq	0x50(%rsp), %rsi
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
               	leaq	0x60(%rsp), %rcx
               	movw	%di, (%rcx,%r8,2)
               	incq	%r8
               	cmpl	$0x8, %r8d
               	jl	<addr>
               	movups	0x60(%rsp), %xmm0
               	movq	0x10(%rsp), %rax
               	movq	0x18(%rsp), %rcx
               	xorl	%edi, %edi
               	vmovq	%rax, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	movq	0x30(%rsp), %rax
               	movq	0x38(%rsp), %rcx
               	vmovq	%rax, %xmm2
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	movq	%r13, %rax
               	sarq	$0x3, %rax
               	movups	%xmm1, 0x40(%rsp)
               	movups	%xmm2, 0x50(%rsp)
               	movq	%rax, %rcx
               	sarq	$0x2, %rcx
               	andq	$0x1, %rcx
               	movq	%rcx, %r8
               	shlq	$0x2, %r8
               	andq	$0x3, %rax
               	movq	%rax, %r9
               	shlq	$0x2, %r9
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	leaq	0x40(%rsp), %rdx
               	leaq	(%r8,%rdi), %rax
               	addq	%rcx, %rax
               	movsbq	(%rdx,%rax), %rdx
               	andq	$0xff, %rdx
               	leaq	0x50(%rsp), %rax
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
               	leaq	0x60(%rsp), %rcx
               	movw	%si, (%rcx,%rdi,2)
               	incq	%rdi
               	cmpl	$0x8, %edi
               	jl	<addr>
               	movups	0x60(%rsp), %xmm1
               	vmovq	%xmm0, %rax
               	vpextrq	$0x1, %xmm0, %rcx
               	vmovq	%xmm1, %rdx
               	vpextrq	$0x1, %xmm1, %rsi
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
               	subq	$0x120, %rsp            # imm = 0x120
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
               	xorl	%ecx, %ecx
               	vmovq	%r13, %xmm0
               	vpinsrq	$0x1, %r14, %xmm0, %xmm0
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movq	%rcx, %xmm14
               	psllw	%xmm14, %xmm0
               	xorl	%ecx, %ecx
               	vmovq	%r15, %xmm1
               	movq	-0x58(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movq	%rcx, %xmm14
               	psllw	%xmm14, %xmm1
               	vmovq	%xmm0, %rcx
               	vpextrq	$0x1, %xmm0, %rdx
               	vmovq	%xmm1, %rsi
               	vpextrq	$0x1, %xmm1, %rdi
               	movq	%rcx, (%rsp)
               	movq	%rdx, 0x8(%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdi, 0x18(%rsp)
               	xorl	%ecx, %ecx
               	vmovq	%r13, %xmm0
               	vpinsrq	$0x1, %r14, %xmm0, %xmm0
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movq	%rcx, %xmm14
               	pslld	%xmm14, %xmm0
               	xorl	%ecx, %ecx
               	vmovq	%r15, %xmm1
               	movq	-0x58(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movq	%rcx, %xmm14
               	pslld	%xmm14, %xmm1
               	vmovq	%xmm0, %rdx
               	vpextrq	$0x1, %xmm0, %rsi
               	vmovq	%xmm1, %rdi
               	vpextrq	$0x1, %xmm1, %r8
               	leaq	(%rsp), %rcx
               	addq	$0x20, %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdi, 0x10(%rcx)
               	movq	%r8, 0x18(%rcx)
               	xorl	%ecx, %ecx
               	vmovq	%r13, %xmm0
               	vpinsrq	$0x1, %r14, %xmm0, %xmm0
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movq	%rcx, %xmm14
               	psllq	%xmm14, %xmm0
               	xorl	%ecx, %ecx
               	vmovq	%r15, %xmm1
               	movq	-0x58(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movq	%rcx, %xmm14
               	psllq	%xmm14, %xmm1
               	vmovq	%xmm0, %rdx
               	vpextrq	$0x1, %xmm0, %rsi
               	vmovq	%xmm1, %rdi
               	vpextrq	$0x1, %xmm1, %r8
               	leaq	(%rsp), %rcx
               	addq	$0x40, %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdi, 0x10(%rcx)
               	movq	%r8, 0x18(%rcx)
               	xorl	%ecx, %ecx
               	vmovq	%r13, %xmm0
               	vpinsrq	$0x1, %r14, %xmm0, %xmm0
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movq	%rcx, %xmm14
               	psrlw	%xmm14, %xmm0
               	xorl	%ecx, %ecx
               	vmovq	%r15, %xmm1
               	movq	-0x58(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movq	%rcx, %xmm14
               	psrlw	%xmm14, %xmm1
               	vmovq	%xmm0, %rdx
               	vpextrq	$0x1, %xmm0, %rsi
               	vmovq	%xmm1, %rdi
               	vpextrq	$0x1, %xmm1, %r8
               	leaq	(%rsp), %rcx
               	addq	$0x60, %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdi, 0x10(%rcx)
               	movq	%r8, 0x18(%rcx)
               	xorl	%ecx, %ecx
               	vmovq	%r13, %xmm0
               	vpinsrq	$0x1, %r14, %xmm0, %xmm0
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movslq	%ecx, %rcx
               	movq	%rcx, %xmm14
               	psrld	%xmm14, %xmm0
               	xorl	%ecx, %ecx
               	vmovq	%r15, %xmm1
               	movq	-0x58(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movslq	%ecx, %rcx
               	movq	%rcx, %xmm14
               	psrld	%xmm14, %xmm1
               	vmovq	%xmm0, %rdx
               	vpextrq	$0x1, %xmm0, %rsi
               	vmovq	%xmm1, %rdi
               	vpextrq	$0x1, %xmm1, %r8
               	leaq	(%rsp), %rcx
               	addq	$0x80, %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdi, 0x10(%rcx)
               	movq	%r8, 0x18(%rcx)
               	xorl	%ecx, %ecx
               	vmovq	%r13, %xmm0
               	vpinsrq	$0x1, %r14, %xmm0, %xmm0
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movslq	%ecx, %rcx
               	movq	%rcx, %xmm14
               	psrlq	%xmm14, %xmm0
               	xorl	%ecx, %ecx
               	vmovq	%r15, %xmm1
               	movq	-0x58(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movslq	%ecx, %rcx
               	movq	%rcx, %xmm14
               	psrlq	%xmm14, %xmm1
               	vmovq	%xmm0, %rdx
               	vpextrq	$0x1, %xmm0, %rsi
               	vmovq	%xmm1, %rdi
               	vpextrq	$0x1, %xmm1, %r8
               	leaq	(%rsp), %rcx
               	addq	$0xa0, %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdi, 0x10(%rcx)
               	movq	%r8, 0x18(%rcx)
               	xorl	%ecx, %ecx
               	vmovq	%r13, %xmm0
               	vpinsrq	$0x1, %r14, %xmm0, %xmm0
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movslq	%ecx, %rcx
               	movq	%rcx, %xmm14
               	psraw	%xmm14, %xmm0
               	xorl	%ecx, %ecx
               	vmovq	%r15, %xmm1
               	movq	-0x58(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movslq	%ecx, %rcx
               	movq	%rcx, %xmm14
               	psraw	%xmm14, %xmm1
               	vmovq	%xmm0, %rdx
               	vpextrq	$0x1, %xmm0, %rsi
               	vmovq	%xmm1, %rdi
               	vpextrq	$0x1, %xmm1, %r8
               	leaq	(%rsp), %rcx
               	addq	$0xc0, %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdi, 0x10(%rcx)
               	movq	%r8, 0x18(%rcx)
               	xorl	%ecx, %ecx
               	vmovq	%r13, %xmm0
               	vpinsrq	$0x1, %r14, %xmm0, %xmm0
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %ecx
               	movslq	%ecx, %rcx
               	movq	%rcx, %xmm14
               	psrad	%xmm14, %xmm0
               	xorl	%ecx, %ecx
               	vmovq	%r15, %xmm1
               	movq	-0x58(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
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
               	movq	%rax, %xmm14
               	psrad	%xmm14, %xmm1
               	vmovq	%xmm0, %rcx
               	vpextrq	$0x1, %xmm0, %rdx
               	vmovq	%xmm1, %rsi
               	vpextrq	$0x1, %xmm1, %rdi
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
               	subq	$0x98, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	vmovups	(%rbx), %ymm14
               	vmovups	%ymm14, -0x60(%rbp)
               	vmovups	(%r12), %ymm14
               	vmovups	%ymm14, -0x80(%rbp)
               	leaq	-0x40(%rbp), %rdx
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
               	leaq	-0x40(%rbp), %rdx
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
               	leaq	-0x40(%rbp), %rdx
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
               	leaq	-0x40(%rbp), %rdx
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
               	leaq	-0x40(%rbp), %rdx
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
               	leaq	-0x40(%rbp), %rdx
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
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufd	$0x1b, %ymm14, %ymm0    # ymm0 = ymm14[3,2,1,0,7,6,5,4]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	leaq	-0x40(%rbp), %rdi
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
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufhw	$0x1b, %ymm14, %ymm0    # ymm0 = ymm14[0,1,2,3,7,6,5,4,8,9,10,11,15,14,13,12]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	leaq	-0x40(%rbp), %rdi
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
               	vmovups	-0x60(%rbp), %ymm14
               	vpshuflw	$0x1b, %ymm14, %ymm0    # ymm0 = ymm14[3,2,1,0,4,5,6,7,11,10,9,8,12,13,14,15]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
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
               	leaq	-0x40(%rbp), %rdx
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
               	leaq	-0x40(%rbp), %rdx
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
               	leaq	-0x40(%rbp), %rdx
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
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufd	$0x0, %ymm14, %ymm0     # ymm0 = ymm14[0,0,0,0,4,4,4,4]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	leaq	-0x40(%rbp), %rdi
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
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufhw	$0x0, %ymm14, %ymm0     # ymm0 = ymm14[0,1,2,3,4,4,4,4,8,9,10,11,12,12,12,12]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	leaq	-0x40(%rbp), %rdi
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
               	vmovups	-0x60(%rbp), %ymm14
               	vpshuflw	$0x0, %ymm14, %ymm0     # ymm0 = ymm14[0,0,0,0,4,5,6,7,8,8,8,8,12,13,14,15]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
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
               	leaq	-0x40(%rbp), %rdx
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
               	leaq	-0x40(%rbp), %rdx
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
               	leaq	-0x40(%rbp), %rdx
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
               	leaq	-0x40(%rbp), %rdx
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
               	leaq	-0x40(%rbp), %rdx
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
               	leaq	-0x40(%rbp), %rdx
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
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufd	$0xe4, %ymm14, %ymm0    # ymm0 = ymm14[0,1,2,3,4,5,6,7]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	movq	%r10, -0x88(%rbp)
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
               	movl	$0xe4, %edx
               	subq	$0x4, %rax
               	shlq	%rax
               	sarxq	%rax, %rdx, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rdx
               	leaq	-0x40(%rbp), %r15
               	movl	$0x2, %r14d
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r15, %rdi
               	movq	%r13, %rdx
               	movq	%r14, %rsi
               	vzeroupper
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x10, %r13d
               	jl	<addr>
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufhw	$0xe4, %ymm14, %ymm0    # ymm0 = ymm14[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x88(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x88(%rbp)
               	xorl	%r13d, %r13d
               	movq	%r13, %rcx
               	andq	$0x8, %rcx
               	movq	%r13, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%r13, %rdx
               	jmp	<addr>
               	movl	$0xe4, %edx
               	shlq	%rax
               	sarxq	%rax, %rdx, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rdx
               	leaq	-0x40(%rbp), %r15
               	movl	$0x2, %r14d
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r15, %rdi
               	movq	%r13, %rdx
               	movq	%r14, %rsi
               	vzeroupper
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x10, %r13d
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpshuflw	$0xe4, %ymm14, %ymm0    # ymm0 = ymm14[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x88(%rbp), %r13
               	orq	%rax, %r13
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	vzeroupper
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movq	%rsi, %rdx
               	vzeroupper
               	callq	<addr>
               	movl	$0x4, %esi
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	vzeroupper
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	vzeroupper
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufd	$0x93, %ymm14, %ymm0    # ymm0 = ymm14[3,0,1,2,7,4,5,6]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%r13, %r10
               	orq	%rax, %r10
               	movq	%r10, -0x88(%rbp)
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
               	movl	$0x93, %edx
               	subq	$0x4, %rax
               	shlq	%rax
               	sarxq	%rax, %rdx, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rdx
               	leaq	-0x40(%rbp), %r15
               	movl	$0x2, %r14d
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r15, %rdi
               	movq	%r13, %rdx
               	movq	%r14, %rsi
               	vzeroupper
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x10, %r13d
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufhw	$0x93, %ymm14, %ymm0    # ymm0 = ymm14[0,1,2,3,7,4,5,6,8,9,10,11,15,12,13,14]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x88(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x88(%rbp)
               	xorl	%r13d, %r13d
               	movq	%r13, %rcx
               	andq	$0x8, %rcx
               	movq	%r13, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%r13, %rdx
               	jmp	<addr>
               	movl	$0x93, %edx
               	shlq	%rax
               	sarxq	%rax, %rdx, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rdx
               	leaq	-0x40(%rbp), %r15
               	movl	$0x2, %r14d
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r15, %rdi
               	movq	%r13, %rdx
               	movq	%r14, %rsi
               	vzeroupper
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x10, %r13d
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpshuflw	$0x93, %ymm14, %ymm0    # ymm0 = ymm14[3,0,1,2,4,5,6,7,11,8,9,10,12,13,14,15]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x88(%rbp), %r13
               	orq	%rax, %r13
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	vzeroupper
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movq	%rsi, %rdx
               	vzeroupper
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	vzeroupper
               	callq	<addr>
               	movl	$0x4, %esi
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	vzeroupper
               	callq	<addr>
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufd	$0x4e, %ymm14, %ymm0    # ymm0 = ymm14[2,3,0,1,6,7,4,5]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%r13, %r10
               	orq	%rax, %r10
               	movq	%r10, -0x88(%rbp)
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
               	leaq	-0x40(%rbp), %r15
               	movl	$0x2, %r14d
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r15, %rdi
               	movq	%r13, %rdx
               	movq	%r14, %rsi
               	vzeroupper
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x10, %r13d
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufhw	$0x4e, %ymm14, %ymm0    # ymm0 = ymm14[0,1,2,3,6,7,4,5,8,9,10,11,14,15,12,13]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x88(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x88(%rbp)
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
               	leaq	-0x40(%rbp), %r15
               	movl	$0x2, %r14d
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r15, %rdi
               	movq	%r13, %rdx
               	movq	%r14, %rsi
               	vzeroupper
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x10, %r13d
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpshuflw	$0x4e, %ymm14, %ymm0    # ymm0 = ymm14[2,3,0,1,4,5,6,7,10,11,8,9,12,13,14,15]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x88(%rbp), %r13
               	orq	%rax, %r13
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	-0x40(%rbp), %rsi
               	leaq	(%rdx,%rax), %rcx
               	movzbq	(%r12,%rcx), %rdi
               	movb	%dil, (%rsi,%rcx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	-0x80(%rbp), %ymm15
               	vpalignr	$0x0, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	0x1(%rax), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	(%rdx,%rax), %rdi
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	leaq	(%rdx,%rcx), %rax
               	movzbq	(%r12,%rax), %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rax
               	subq	$0x10, %rax
               	movzbq	(%rbx,%rax), %rax
               	movb	%al, (%rsi,%rdi)
               	movq	%rcx, %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	-0x80(%rbp), %ymm15
               	vpalignr	$0x1, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],ymm14[0],ymm15[17,18,19,20,21,22,23,24,25,26,27,28,29,30,31],ymm14[16]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	0x7(%rax), %rdx
               	leaq	-0x40(%rbp), %rsi
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
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	-0x80(%rbp), %ymm15
               	vpalignr	$0x7, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[7,8,9,10,11,12,13,14,15],ymm14[0,1,2,3,4,5,6],ymm15[23,24,25,26,27,28,29,30,31],ymm14[16,17,18,19,20,21,22]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	0xf(%rax), %rdx
               	leaq	-0x40(%rbp), %rsi
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
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	-0x80(%rbp), %ymm15
               	vpalignr	$0xf, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[15],ymm14[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14],ymm15[31],ymm14[16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
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
               	leaq	-0x40(%rbp), %rsi
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
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	-0x80(%rbp), %ymm15
               	vpalignr	$0x10, %ymm15, %ymm14, %ymm0 # ymm0 = ymm14[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	0x11(%rax), %rcx
               	leaq	-0x40(%rbp), %rsi
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
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	-0x80(%rbp), %ymm15
               	vpalignr	$0x11, %ymm15, %ymm14, %ymm0 # ymm0 = ymm14[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,0]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	0x1f(%rax), %rcx
               	leaq	-0x40(%rbp), %rsi
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
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	-0x80(%rbp), %ymm15
               	vpalignr	$0x1f, %ymm15, %ymm14, %ymm0 # ymm0 = ymm14[15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	(%rdx,%rax), %rdi
               	movb	%cl, (%rsi,%rdi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	-0x80(%rbp), %ymm15
               	vpalignr	$0x20, %ymm15, %ymm14, %ymm0 # ymm0 = ymm14[16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	-0x40(%rbp), %rsi
               	leaq	(%rdx,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rdi
               	movb	%dil, (%rsi,%rcx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpslldq	$0x0, %ymm14, %ymm0     # ymm0 = ymm14[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	-0x40(%rbp), %rsi
               	leaq	(%rdx,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rdi
               	movb	%dil, (%rsi,%rcx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpsrldq	$0x0, %ymm14, %ymm0     # ymm0 = ymm14[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	leaq	-0x40(%rbp), %rdi
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
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpslldq	$0x3, %ymm14, %ymm0     # ymm0 = zero,zero,zero,ymm14[0,1,2,3,4,5,6,7,8,9,10,11,12],zero,zero,zero,ymm14[16,17,18,19,20,21,22,23,24,25,26,27,28]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	leaq	-0x40(%rbp), %rdi
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
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpsrldq	$0x3, %ymm14, %ymm0     # ymm0 = ymm14[3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero,ymm14[19,20,21,22,23,24,25,26,27,28,29,30,31],zero,zero,zero
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	leaq	-0x40(%rbp), %rdi
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
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpslldq	$0xf, %ymm14, %ymm0     # ymm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,ymm14[0],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,ymm14[16]
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	leaq	-0x40(%rbp), %rdi
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
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpsrldq	$0xf, %ymm14, %ymm0     # ymm0 = ymm14[15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,ymm14[31],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
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
               	leaq	-0x40(%rbp), %rsi
               	leaq	(%rdx,%rax), %rdi
               	movb	%cl, (%rsi,%rdi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpslldq	$0x10, %ymm14, %ymm0    # ymm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	(%rdx,%rax), %rdi
               	movb	%cl, (%rsi,%rdi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpsrldq	$0x10, %ymm14, %ymm0    # ymm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rdi
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rbx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leaq	-0xc0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<check_blends>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	vmovups	(%rbx), %ymm14
               	vmovups	%ymm14, 0x90(%rsp)
               	vmovups	(%r12), %ymm14
               	vmovups	%ymm14, 0x70(%rsp)
               	movups	(%rbx), %xmm14
               	movups	%xmm14, 0x60(%rsp)
               	movups	(%r12), %xmm14
               	movups	%xmm14, 0x50(%rsp)
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %rdi
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
               	vmovups	0x90(%rsp), %ymm14
               	vmovups	0x70(%rsp), %ymm15
               	vpblendw	$0x0, %ymm15, %ymm14, %ymm0 # ymm0 = ymm14[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %rdi
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
               	xorl	%eax, %eax
               	vmovups	0x90(%rsp), %ymm0
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm0, %rcx
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	vmovups	0x70(%rsp), %ymm1
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm3
               	vpextrq	$0x1, %xmm1, %rcx
               	vpinsrq	$0x1, %rcx, %xmm3, %xmm3
               	blendps	$0x0, %xmm3, %xmm2      # xmm2 = xmm2[0,1,2,3]
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	xorl	%eax, %eax
               	vextracti128	$0x1, %ymm1, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm1, %rcx
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	blendps	$0x0, %xmm1, %xmm0      # xmm0 = xmm0[0,1,2,3]
               	vmovq	%xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rcx
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	xorl	%ecx, %ecx
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movups	0x50(%rsp), %xmm14
               	movups	0x60(%rsp), %xmm0
               	blendps	$0x0, %xmm14, %xmm0     # xmm0 = xmm0[0,1,2,3]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %rdi
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
               	vmovups	0x90(%rsp), %ymm14
               	vmovups	0x70(%rsp), %ymm15
               	vpblendw	$0xff, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %rdi
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
               	xorl	%eax, %eax
               	vmovups	0x90(%rsp), %ymm0
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm0, %rcx
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	vmovups	0x70(%rsp), %ymm1
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm3
               	vpextrq	$0x1, %xmm1, %rcx
               	vpinsrq	$0x1, %rcx, %xmm3, %xmm3
               	blendps	$0xf, %xmm3, %xmm2      # xmm2 = xmm3[0,1,2,3]
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	xorl	%eax, %eax
               	vextracti128	$0x1, %ymm1, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm1, %rcx
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	blendps	$0xf, %xmm1, %xmm0      # xmm0 = xmm1[0,1,2,3]
               	vmovq	%xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rcx
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	xorl	%ecx, %ecx
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movups	0x50(%rsp), %xmm14
               	movups	0x60(%rsp), %xmm0
               	blendps	$0xf, %xmm14, %xmm0     # xmm0 = xmm14[0,1,2,3]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %rdi
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
               	vmovups	0x90(%rsp), %ymm14
               	vmovups	0x70(%rsp), %ymm15
               	vpblendw	$0xa5, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[0],ymm14[1],ymm15[2],ymm14[3,4],ymm15[5],ymm14[6],ymm15[7,8],ymm14[9],ymm15[10],ymm14[11,12],ymm15[13],ymm14[14],ymm15[15]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %rdi
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
               	xorl	%eax, %eax
               	vmovups	0x90(%rsp), %ymm0
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm0, %rcx
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	vmovups	0x70(%rsp), %ymm1
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm3
               	vpextrq	$0x1, %xmm1, %rcx
               	vpinsrq	$0x1, %rcx, %xmm3, %xmm3
               	blendps	$0x5, %xmm3, %xmm2      # xmm2 = xmm3[0],xmm2[1],xmm3[2],xmm2[3]
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	xorl	%eax, %eax
               	vextracti128	$0x1, %ymm1, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm1, %rcx
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	blendps	$0xa, %xmm1, %xmm0      # xmm0 = xmm0[0],xmm1[1],xmm0[2],xmm1[3]
               	vmovq	%xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rcx
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	xorl	%ecx, %ecx
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movups	0x50(%rsp), %xmm14
               	movups	0x60(%rsp), %xmm0
               	blendps	$0x5, %xmm14, %xmm0     # xmm0 = xmm14[0],xmm0[1],xmm14[2],xmm0[3]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %rdi
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
               	vmovups	0x90(%rsp), %ymm14
               	vmovups	0x70(%rsp), %ymm15
               	vpblendw	$0x5a, %ymm15, %ymm14, %ymm0 # ymm0 = ymm14[0],ymm15[1],ymm14[2],ymm15[3,4],ymm14[5],ymm15[6],ymm14[7,8],ymm15[9],ymm14[10],ymm15[11,12],ymm14[13],ymm15[14],ymm14[15]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %rdi
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
               	xorl	%eax, %eax
               	vmovups	0x90(%rsp), %ymm0
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm0, %rcx
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	vmovups	0x70(%rsp), %ymm1
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm3
               	vpextrq	$0x1, %xmm1, %rcx
               	vpinsrq	$0x1, %rcx, %xmm3, %xmm3
               	blendps	$0xa, %xmm3, %xmm2      # xmm2 = xmm2[0],xmm3[1],xmm2[2],xmm3[3]
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	xorl	%eax, %eax
               	vextracti128	$0x1, %ymm1, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm1, %rcx
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	blendps	$0x5, %xmm1, %xmm0      # xmm0 = xmm1[0],xmm0[1],xmm1[2],xmm0[3]
               	vmovq	%xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rcx
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	xorl	%ecx, %ecx
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movups	0x50(%rsp), %xmm14
               	movups	0x60(%rsp), %xmm0
               	blendps	$0xa, %xmm14, %xmm0     # xmm0 = xmm0[0],xmm14[1],xmm0[2],xmm14[3]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %rdi
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
               	vmovups	0x90(%rsp), %ymm14
               	vmovups	0x70(%rsp), %ymm15
               	vpblendw	$0x81, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[0],ymm14[1,2,3,4,5,6],ymm15[7,8],ymm14[9,10,11,12,13,14],ymm15[15]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x81, %eax
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
               	xorl	%eax, %eax
               	vmovups	0x90(%rsp), %ymm0
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm0, %rcx
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	vmovups	0x70(%rsp), %ymm1
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm3
               	vpextrq	$0x1, %xmm1, %rcx
               	vpinsrq	$0x1, %rcx, %xmm3, %xmm3
               	blendps	$0x1, %xmm3, %xmm2      # xmm2 = xmm3[0],xmm2[1,2,3]
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	xorl	%eax, %eax
               	vextracti128	$0x1, %ymm1, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm1, %rcx
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	blendps	$0x8, %xmm1, %xmm0      # xmm0 = xmm0[0,1,2],xmm1[3]
               	vmovq	%xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rcx
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	xorl	%ecx, %ecx
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movups	0x50(%rsp), %xmm14
               	movups	0x60(%rsp), %xmm0
               	blendps	$0x1, %xmm14, %xmm0     # xmm0 = xmm14[0],xmm0[1,2,3]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %rdi
               	movl	$0xf, %eax
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
               	vmovups	0x90(%rsp), %ymm14
               	vmovups	0x70(%rsp), %ymm15
               	vpblendw	$0xf, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[0,1,2,3],ymm14[4,5,6,7],ymm15[8,9,10,11],ymm14[12,13,14,15]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %rdi
               	movl	$0xf, %eax
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
               	xorl	%eax, %eax
               	vmovups	0x90(%rsp), %ymm0
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm0, %rcx
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	vmovups	0x70(%rsp), %ymm1
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm3
               	vpextrq	$0x1, %xmm1, %rcx
               	vpinsrq	$0x1, %rcx, %xmm3, %xmm3
               	blendps	$0xf, %xmm3, %xmm2      # xmm2 = xmm3[0,1,2,3]
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	xorl	%eax, %eax
               	vextracti128	$0x1, %ymm1, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm1, %rcx
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	blendps	$0x0, %xmm1, %xmm0      # xmm0 = xmm0[0,1,2,3]
               	vmovq	%xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rcx
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	xorl	%ecx, %ecx
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movups	0x50(%rsp), %xmm14
               	movups	0x60(%rsp), %xmm0
               	blendps	$0xf, %xmm14, %xmm0     # xmm0 = xmm14[0,1,2,3]
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	xorl	%eax, %eax
               	leaq	-0x40(%rbp), %rdx
               	movzbq	(%r13,%rax), %rcx
               	testb	$-0x80, %cl
               	je	<addr>
               	movzbq	(%r12,%rax), %rcx
               	jmp	<addr>
               	movzbq	(%rbx,%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	vmovups	(%r13), %ymm0
               	xorl	%eax, %eax
               	vmovups	0x90(%rsp), %ymm1
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm1, %rcx
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	vmovups	0x70(%rsp), %ymm1
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm3
               	vpextrq	$0x1, %xmm1, %rcx
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm3
               	vpextrq	$0x1, %xmm0, %rcx
               	vpinsrq	$0x1, %rcx, %xmm3, %xmm3
               	leaq	-0xd0(%rbp), %rcx
               	movups	%xmm2, -0xd0(%rbp)
               	leaq	-0xc0(%rbp), %rdx
               	movups	%xmm1, -0xc0(%rbp)
               	leaq	-0xb0(%rbp), %rsi
               	movups	%xmm3, -0xb0(%rbp)
               	movsbq	(%rsi,%rax), %rdi
               	testb	$-0x80, %dil
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movb	%dil, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xd0(%rbp), %rcx
               	movups	-0xd0(%rbp), %xmm1
               	xorl	%eax, %eax
               	vmovups	0x90(%rsp), %ymm2
               	vextracti128	$0x1, %ymm2, %xmm3
               	vmovq	%xmm3, %rdx
               	vmovq	%rdx, %xmm3
               	vextracti128	$0x1, %ymm2, %xmm2
               	vpextrq	$0x1, %xmm2, %rdx
               	vpinsrq	$0x1, %rdx, %xmm3, %xmm3
               	vmovups	0x70(%rsp), %ymm2
               	vextracti128	$0x1, %ymm2, %xmm4
               	vmovq	%xmm4, %rdx
               	vmovq	%rdx, %xmm4
               	vextracti128	$0x1, %ymm2, %xmm2
               	vpextrq	$0x1, %xmm2, %rdx
               	movapd	%xmm4, %xmm2
               	vpinsrq	$0x1, %rdx, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm4
               	vmovq	%xmm4, %rdx
               	vmovq	%rdx, %xmm4
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rdx
               	movapd	%xmm4, %xmm0
               	vpinsrq	$0x1, %rdx, %xmm0, %xmm0
               	movups	%xmm3, -0xd0(%rbp)
               	leaq	-0xc0(%rbp), %rdx
               	movups	%xmm2, -0xc0(%rbp)
               	leaq	-0xb0(%rbp), %rsi
               	movups	%xmm0, -0xb0(%rbp)
               	movsbq	(%rsi,%rax), %rdi
               	testb	$-0x80, %dil
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movb	%dil, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	-0xd0(%rbp), %xmm0
               	xorl	%eax, %eax
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm1, %rcx
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%r14, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
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
               	subq	$0x1a0, %rsp            # imm = 0x1A0
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movups	(%rbx), %xmm0
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
               	pmovsxbw	%xmm0, %xmm1
               	movapd	%xmm0, %xmm2
               	psrldq	$0x8, %xmm2             # xmm2 = xmm2[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	pmovsxbw	%xmm2, %xmm2
               	vmovq	%xmm1, %rcx
               	vpextrq	$0x1, %xmm1, %rdx
               	vmovq	%xmm2, %rsi
               	vpextrq	$0x1, %xmm2, %rdi
               	movq	%rcx, (%rsp)
               	movq	%rdx, 0x8(%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdi, 0x18(%rsp)
               	pmovsxbd	%xmm0, %xmm1
               	movapd	%xmm0, %xmm2
               	psrldq	$0x4, %xmm2             # xmm2 = xmm2[4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero,zero
               	pmovsxbd	%xmm2, %xmm2
               	vmovq	%xmm1, %rcx
               	vpextrq	$0x1, %xmm1, %rdx
               	vmovq	%xmm2, %rsi
               	vpextrq	$0x1, %xmm2, %rdi
               	addq	$0x20, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	pmovsxbq	%xmm0, %xmm1
               	movapd	%xmm0, %xmm2
               	psrldq	$0x2, %xmm2             # xmm2 = xmm2[2,3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero
               	pmovsxbq	%xmm2, %xmm2
               	vmovq	%xmm1, %rdx
               	vpextrq	$0x1, %xmm1, %rsi
               	vmovq	%xmm2, %rdi
               	vpextrq	$0x1, %xmm2, %r8
               	leaq	(%rsp), %rcx
               	leaq	0x40(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	pmovsxwd	%xmm0, %xmm1
               	movapd	%xmm0, %xmm2
               	psrldq	$0x8, %xmm2             # xmm2 = xmm2[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	pmovsxwd	%xmm2, %xmm2
               	vmovq	%xmm1, %rdx
               	vpextrq	$0x1, %xmm1, %rsi
               	vmovq	%xmm2, %rdi
               	vpextrq	$0x1, %xmm2, %r8
               	leaq	0x60(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	pmovsxwq	%xmm0, %xmm1
               	movapd	%xmm0, %xmm2
               	psrldq	$0x4, %xmm2             # xmm2 = xmm2[4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero,zero
               	pmovsxwq	%xmm2, %xmm2
               	vmovq	%xmm1, %rdx
               	vpextrq	$0x1, %xmm1, %rsi
               	vmovq	%xmm2, %rdi
               	vpextrq	$0x1, %xmm2, %r8
               	leaq	0x80(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	pmovsxdq	%xmm0, %xmm1
               	movapd	%xmm0, %xmm2
               	psrldq	$0x8, %xmm2             # xmm2 = xmm2[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	pmovsxdq	%xmm2, %xmm2
               	vmovq	%xmm1, %rdx
               	vpextrq	$0x1, %xmm1, %rsi
               	vmovq	%xmm2, %rdi
               	vpextrq	$0x1, %xmm2, %r8
               	leaq	(%rsp), %rcx
               	leaq	0xa0(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	pmovzxbw	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
               	movapd	%xmm0, %xmm2
               	psrldq	$0x8, %xmm2             # xmm2 = xmm2[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	pmovzxbw	%xmm2, %xmm2            # xmm2 = xmm2[0],zero,xmm2[1],zero,xmm2[2],zero,xmm2[3],zero,xmm2[4],zero,xmm2[5],zero,xmm2[6],zero,xmm2[7],zero
               	vmovq	%xmm1, %rdx
               	vpextrq	$0x1, %xmm1, %rsi
               	vmovq	%xmm2, %rdi
               	vpextrq	$0x1, %xmm2, %r8
               	leaq	0xc0(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	pmovzxbd	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero
               	movapd	%xmm0, %xmm2
               	psrldq	$0x4, %xmm2             # xmm2 = xmm2[4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero,zero
               	pmovzxbd	%xmm2, %xmm2            # xmm2 = xmm2[0],zero,zero,zero,xmm2[1],zero,zero,zero,xmm2[2],zero,zero,zero,xmm2[3],zero,zero,zero
               	vmovq	%xmm1, %rdx
               	vpextrq	$0x1, %xmm1, %rsi
               	vmovq	%xmm2, %rdi
               	vpextrq	$0x1, %xmm2, %r8
               	leaq	0xe0(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	pmovzxbq	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,zero,zero,zero,zero,zero,zero,xmm0[1],zero,zero,zero,zero,zero,zero,zero
               	movapd	%xmm0, %xmm2
               	psrldq	$0x2, %xmm2             # xmm2 = xmm2[2,3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero
               	pmovzxbq	%xmm2, %xmm2            # xmm2 = xmm2[0],zero,zero,zero,zero,zero,zero,zero,xmm2[1],zero,zero,zero,zero,zero,zero,zero
               	vmovq	%xmm1, %rdx
               	vpextrq	$0x1, %xmm1, %rsi
               	vmovq	%xmm2, %rdi
               	vpextrq	$0x1, %xmm2, %r8
               	leaq	(%rsp), %rcx
               	leaq	0x100(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	pmovzxwd	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
               	movapd	%xmm0, %xmm2
               	psrldq	$0x8, %xmm2             # xmm2 = xmm2[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	pmovzxwd	%xmm2, %xmm2            # xmm2 = xmm2[0],zero,xmm2[1],zero,xmm2[2],zero,xmm2[3],zero
               	vmovq	%xmm1, %rdx
               	vpextrq	$0x1, %xmm1, %rsi
               	vmovq	%xmm2, %rdi
               	vpextrq	$0x1, %xmm2, %r8
               	leaq	0x120(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	pmovzxwq	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero
               	movapd	%xmm0, %xmm2
               	psrldq	$0x4, %xmm2             # xmm2 = xmm2[4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero,zero
               	pmovzxwq	%xmm2, %xmm2            # xmm2 = xmm2[0],zero,zero,zero,xmm2[1],zero,zero,zero
               	vmovq	%xmm1, %rdx
               	vpextrq	$0x1, %xmm1, %rsi
               	vmovq	%xmm2, %rdi
               	vpextrq	$0x1, %xmm2, %r8
               	leaq	0x140(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	pmovzxdq	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,xmm0[1],zero
               	psrldq	$0x8, %xmm0             # xmm0 = xmm0[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	pmovzxdq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero,xmm0[1],zero
               	vmovq	%xmm1, %rcx
               	vpextrq	$0x1, %xmm1, %rdx
               	vmovq	%xmm0, %rsi
               	vpextrq	$0x1, %xmm0, %rdi
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
               	subq	$0x58, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movups	(%rbx), %xmm14
               	movups	%xmm14, -0x50(%rbp)
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
               	movups	-0x50(%rbp), %xmm14
               	vpextrb	$0x0, %xmm14, %eax
               	movsbq	%al, %rax
               	movsbq	%al, %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm0
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	leaq	0x70(%rsp), %rax
               	movups	%xmm0, 0x70(%rsp)
               	jmp	<addr>
               	cmpl	$0x1, %r12d
               	jne	<addr>
               	movups	-0x50(%rbp), %xmm14
               	vpextrw	$0x0, %xmm14, %eax
               	movswq	%ax, %rax
               	movswq	%ax, %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm0
               	vpinsrw	$0x0, %eax, %xmm0, %xmm0
               	vpinsrw	$0x1, %eax, %xmm0, %xmm0
               	vpinsrw	$0x2, %eax, %xmm0, %xmm0
               	vpinsrw	$0x3, %eax, %xmm0, %xmm0
               	vpinsrw	$0x4, %eax, %xmm0, %xmm0
               	vpinsrw	$0x5, %eax, %xmm0, %xmm0
               	vpinsrw	$0x6, %eax, %xmm0, %xmm0
               	vpinsrw	$0x7, %eax, %xmm0, %xmm0
               	leaq	0x50(%rsp), %rax
               	movups	%xmm0, 0x50(%rsp)
               	jmp	<addr>
               	cmpl	$0x2, %r12d
               	jne	<addr>
               	movups	-0x50(%rbp), %xmm14
               	vmovd	%xmm14, %eax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	xorl	%ecx, %ecx
               	vmovd	%eax, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	leaq	0x60(%rsp), %rax
               	movups	%xmm0, 0x60(%rsp)
               	jmp	<addr>
               	movups	-0x50(%rbp), %xmm14
               	vmovq	%xmm14, %rax
               	xorl	%ecx, %ecx
               	vmovq	%rax, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	leaq	(%rsp), %rax
               	movups	%xmm0, (%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x20(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	movslq	%eax, %rax
               	xorl	%ecx, %ecx
               	vmovd	%eax, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movups	%xmm0, 0x50(%rsp)
               	movl	0x20(%rsp), %eax
               	movl	%eax, 0x20(%rsp)
               	movl	%eax, 0x24(%rsp)
               	movl	%eax, 0x28(%rsp)
               	movl	%eax, 0x2c(%rsp)
               	movl	%eax, 0x30(%rsp)
               	movl	%eax, 0x34(%rsp)
               	movl	%eax, 0x38(%rsp)
               	movl	%eax, 0x3c(%rsp)
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rsi
               	movq	%rax, (%rsp)
               	movq	%rcx, 0x8(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rsi, 0x18(%rsp)
               	leaq	0x50(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	xorl	%ecx, %ecx
               	vmovq	%rax, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	leaq	0x60(%rsp), %rdi
               	movups	%xmm0, 0x60(%rsp)
               	movq	0x20(%rsp), %rax
               	movq	%rax, 0x20(%rsp)
               	movq	%rax, 0x28(%rsp)
               	movq	%rax, 0x30(%rsp)
               	movq	%rax, 0x38(%rsp)
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	movups	-0x50(%rbp), %xmm0
               	vmovdqa	%xmm0, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	leaq	-0x70(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	vzeroupper
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
               	xorl	%r15d, %r15d
               	movq	%r15, 0x38(%rsp)
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
               	vmovups	-0xa0(%rbp), %ymm14
               	vmovups	%ymm14, 0x40(%rsp)
               	xorl	%r12d, %r12d
               	movq	%r12, %r14
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%r12,4), %rbx
               	movl	$0x20, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%r13, %rdi
               	movq	%rbx, %r8
               	vzeroupper
               	callq	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovq	%rbx, %xmm15
               	vpsllw	%xmm15, %ymm14, %ymm0
               	leaq	-0x40(%rbp), %rsi
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movl	$0x20, %esi
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%r13, %rdi
               	movq	%rbx, %r8
               	vzeroupper
               	callq	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovq	%rbx, %xmm15
               	vpsrlw	%xmm15, %ymm14, %ymm0
               	leaq	-0x40(%rbp), %rsi
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movl	$0x20, %esi
               	movl	$0x2, %edx
               	leaq	-0x40(%rbp), %r9
               	movq	%r13, %rdi
               	movq	%rbx, %r8
               	movq	%rdx, %rcx
               	vzeroupper
               	callq	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovq	%rbx, %xmm15
               	vpsraw	%xmm15, %ymm14, %ymm0
               	leaq	-0x40(%rbp), %rsi
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movl	$0x20, %esi
               	movl	$0x4, %edx
               	movl	$0x2, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%r13, %rdi
               	movq	%rbx, %r8
               	vzeroupper
               	callq	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovq	%rbx, %xmm15
               	vpsrad	%xmm15, %ymm14, %ymm0
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	incq	%r12
               	cmpl	$0xb, %r12d
               	jb	<addr>
               	testq	%r14, %r14
               	je	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	movq	0x38(%rsp), %rbx
               	orq	%rax, %rbx
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0xa0(%rbp), %rdi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	leaq	-0x60(%rbp), %rdx
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0xa0(%rbp), %rdi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0xa0(%rbp), %rdi
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %r10
               	orq	%rax, %r10
               	movq	%r10, 0x38(%rsp)
               	incq	%r15
               	cmpl	$0xc8, %r15d
               	jl	<addr>
               	movq	0x38(%rsp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq


avx2_shifts_shuffles_and_blends_follow_the_sdm.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<next>:
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	retq

<lane>:
               	xorl	%eax, %eax
               	leaq	-0x1(%rsi), %r8
               	imulq	%rsi, %rdx
               	testl	%r8d, %r8d
               	jl	<addr>
               	shlq	$0x8, %rax
               	leaq	(%rdx,%r8), %r9
               	movslq	%r9d, %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rax
               	decq	%r8
               	testl	%r8d, %r8d
               	jge	<addr>
               	testl	%ecx, %ecx
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
               	imulq	%rsi, %rdx
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	(%rdx,%rax), %r8
               	movslq	%r8d, %r9
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi,%r9)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	retq

<same>:
               	subq	$0x28, %rsp
               	movq	%rdi, %rsi
               	vmovups	%ymm0, (%rsp)
               	leaq	(%rsp), %rdi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	vzeroupper
               	addq	$0x28, %rsp
               	retq

<shift>:
               	movq	%rsi, %rax
               	shlq	$0x3, %rax
               	movslq	%eax, %r8
               	cmpl	$0x8, %esi
               	jne	<addr>
               	movq	$-0x1, %rax
               	andq	%rdi, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	xorl	%edx, %edx
               	shlxq	%rcx, %rax, %rax
               	cmpq	%r8, %rcx
               	cmovaeq	%rdx, %rax
               	retq
               	cmpl	$0x1, %edx
               	jne	<addr>
               	xorl	%edx, %edx
               	shrxq	%rcx, %rax, %rax
               	cmpq	%r8, %rcx
               	cmovaeq	%rdx, %rax
               	retq
               	leaq	-0x1(%r8), %rax
               	movslq	%eax, %rax
               	movslq	%ecx, %rdx
               	cmpq	%r8, %rcx
               	cmovbq	%rdx, %rax
               	sarxq	%rax, %rdi, %rax
               	retq
               	movl	$0x1, %eax
               	shlxq	%r8, %rax, %rax
               	decq	%rax
               	jmp	<addr>

<model_shift>:
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movl	$0x20, %r15d
               	movq	%rdx, %rbx
               	xorl	%r13d, %r13d
               	leaq	-0x1(%rbx), %r12
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rdx
               	movslq	%edx, %rbp
               	movslq	%eax, %r14
               	leaq	-0x1(%r14), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x38(%rsp)
               	movl	%r15d, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %r13d
               	jge	<addr>
               	cmpl	$0x2, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%esi, %esi
               	movq	%rbx, %rdx
               	imulq	%r13, %rdx
               	movq	%r12, %r10
               	testl	%r10d, %r10d
               	jl	<addr>
               	shlq	$0x8, %rsi
               	leaq	(%rdx,%r10), %r11
               	movslq	%r11d, %r11
               	movzbq	(%rdi,%r11), %r11
               	orq	%r11, %rsi
               	decq	%r10
               	nopl	(%rax)
               	testl	%r10d, %r10d
               	jge	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x8, %ebx
               	jge	<addr>
               	shrxq	%rbp, %rsi, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	shlxq	%r14, %rax, %rax
               	orq	%rax, %rsi
               	cmpl	$0x8, %ebx
               	jne	<addr>
               	movq	$-0x1, %rdx
               	andq	%rsi, %rdx
               	nopw	(%rax,%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	xorl	%eax, %eax
               	shlxq	%r8, %rdx, %rdx
               	cmpq	%r14, %r8
               	cmovaeq	%rax, %rdx
               	movq	%rbx, %r11
               	imulq	%r13, %r11
               	xorl	%esi, %esi
               	nopl	(%rax,%rax)
               	cmpl	%ebx, %esi
               	jge	<addr>
               	leaq	(%r11,%rsi), %r10
               	movslq	%r10d, %rax
               	movq	%rsi, %r10
               	shlq	$0x3, %r10
               	movslq	%r10d, %r10
               	shrxq	%r10, %rdx, %r10
               	andq	$0xff, %r10
               	movb	%r10b, (%r9,%rax)
               	incq	%rsi
               	cmpl	%ebx, %esi
               	jl	<addr>
               	jmp	<addr>
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	xorl	%eax, %eax
               	shrxq	%r8, %rdx, %rdx
               	cmpq	%r14, %r8
               	cmovaeq	%rax, %rdx
               	jmp	<addr>
               	movslq	%r8d, %rax
               	cmpq	%r14, %r8
               	movq	0x38(%rsp), %r10
               	cmovaeq	%r10, %rax
               	sarxq	%rax, %rsi, %rdx
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	movl	$0x1, %eax
               	shlxq	%r14, %rax, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	incq	%r13
               	movl	%r15d, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %r13d
               	jl	<addr>
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x18, %rsp
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
               	movq	%rdi, %r13
               	movq	%rsi, -0x68(%rbp)
               	leaq	(%rsp), %rax
               	vmovups	(%r13), %ymm14
               	vmovups	%ymm14, (%rax)
               	movq	(%r13), %r14
               	movq	0x8(%r13), %r15
               	movq	0x10(%r13), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	0x18(%r13), %r10
               	movq	%r10, -0x60(%rbp)
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	leaq	-0x48(%rbp), %rax
               	movq	-0x68(%rbp), %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rax)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %rax
               	vmovq	%r14, %xmm0
               	vpinsrq	$0x1, %r15, %xmm0, %xmm0
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movq	%rcx, %xmm14
               	psllw	%xmm14, %xmm0
               	movq	-0x58(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x60(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movq	%rcx, %xmm14
               	psllw	%xmm14, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm0, %rcx
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm1, %rcx
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, (%rsp)
               	vmovq	%r14, %xmm0
               	vpinsrq	$0x1, %r15, %xmm0, %xmm0
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movq	%rcx, %xmm14
               	pslld	%xmm14, %xmm0
               	movq	-0x58(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x60(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movq	%rcx, %xmm14
               	pslld	%xmm14, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm0, %rcx
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm1, %rcx
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x20(%rsp)
               	vmovq	%r14, %xmm0
               	vpinsrq	$0x1, %r15, %xmm0, %xmm0
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movq	%rcx, %xmm14
               	psllq	%xmm14, %xmm0
               	movq	-0x58(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x60(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movq	%rcx, %xmm14
               	psllq	%xmm14, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm0, %rcx
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm1, %rcx
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	vmovq	%r14, %xmm0
               	vpinsrq	$0x1, %r15, %xmm0, %xmm0
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movq	%rcx, %xmm14
               	psrlw	%xmm14, %xmm0
               	movq	-0x58(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x60(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movq	%rcx, %xmm14
               	psrlw	%xmm14, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm0, %rcx
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm1, %rcx
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x60(%rsp)
               	vmovq	%r14, %xmm0
               	vpinsrq	$0x1, %r15, %xmm0, %xmm0
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %xmm14
               	psrld	%xmm14, %xmm0
               	movq	-0x58(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x60(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %xmm14
               	psrld	%xmm14, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm0, %rcx
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm1, %rcx
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovq	%r14, %xmm0
               	vpinsrq	$0x1, %r15, %xmm0, %xmm0
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %xmm14
               	psrlq	%xmm14, %xmm0
               	movq	-0x58(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x60(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %xmm14
               	psrlq	%xmm14, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm0, %rcx
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm1, %rcx
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0xa0(%rsp)
               	vmovq	%r14, %xmm0
               	vpinsrq	$0x1, %r15, %xmm0, %xmm0
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %xmm14
               	psraw	%xmm14, %xmm0
               	movq	-0x58(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x60(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %xmm14
               	psraw	%xmm14, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm0, %rcx
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm1, %rcx
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	vmovq	%r14, %xmm0
               	vpinsrq	$0x1, %r15, %xmm0, %xmm0
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %xmm14
               	psrad	%xmm14, %xmm0
               	movq	-0x58(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x60(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovaq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rax, %xmm14
               	psrad	%xmm14, %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0xe0(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	movq	%r13, %rdi
               	movl	$0x20, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %r9
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x100(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x100(%rsp), %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	movq	%r13, %rdi
               	movl	$0x20, %esi
               	movl	$0x4, %edx
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %r9
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x20, %rax
               	leaq	0x120(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x120(%rsp), %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	movq	%r13, %rdi
               	movl	$0x20, %esi
               	movl	$0x8, %edx
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %r9
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x40, %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	movq	%r13, %rdi
               	movl	$0x20, %esi
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	leaq	-0x40(%rbp), %r9
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x60, %rax
               	leaq	0x160(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x160(%rsp), %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	movq	%r13, %rdi
               	movl	$0x20, %esi
               	movl	$0x4, %edx
               	movl	$0x1, %ecx
               	leaq	-0x40(%rbp), %r9
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x80, %rax
               	leaq	0x180(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x180(%rsp), %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	movq	%r13, %rdi
               	movl	$0x20, %esi
               	movl	$0x8, %edx
               	movl	$0x1, %ecx
               	leaq	-0x40(%rbp), %r9
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rax
               	addq	$0xa0, %rax
               	leaq	0x1a0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x1a0(%rsp), %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	movq	%r13, %rdi
               	movl	$0x20, %esi
               	movl	$0x2, %edx
               	movl	$0x2, %ecx
               	leaq	-0x40(%rbp), %r9
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rax
               	addq	$0xc0, %rax
               	leaq	0x1c0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x1c0(%rsp), %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r8
               	movq	%r13, %rdi
               	movl	$0x20, %esi
               	movl	$0x4, %edx
               	movl	$0x2, %ecx
               	leaq	-0x40(%rbp), %r9
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rax
               	addq	$0xe0, %rax
               	leaq	0x1e0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x1e0(%rsp), %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	incq	%rbx
               	cmpl	$0xc, %ebx
               	jb	<addr>
               	movl	$0x2, %eax
               	xorl	%ecx, %ecx
               	testq	%r12, %r12
               	cmoveq	%rcx, %rax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq

<check_variable_shifts>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x3d, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	shrq	$0x8, %rcx
               	movl	%ecx, %edx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x60(%rbp,%rax)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x3d, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	shrq	$0x8, %rcx
               	movl	%ecx, %edx
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x60(%rbp,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x3d, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	shrq	$0x8, %rcx
               	movl	%ecx, %edx
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x60(%rbp,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x3d, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	shrq	$0x8, %rcx
               	movl	%ecx, %edx
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x60(%rbp,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x3d, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	shrq	$0x8, %rcx
               	movl	%ecx, %edx
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x60(%rbp,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x3d, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	shrq	$0x8, %rcx
               	movl	%ecx, %edx
               	xorl	%eax, %eax
               	leaq	0x14(%rax), %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x60(%rbp,%rsi)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x3d, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	shrq	$0x8, %rcx
               	movl	%ecx, %edx
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x60(%rbp,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x3d, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	shrq	$0x8, %rcx
               	movl	%ecx, %edx
               	xorl	%eax, %eax
               	leaq	0x1c(%rax), %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x60(%rbp,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x3d, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	shrq	$0x8, %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	shrxq	%rax, %rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rcx)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x3d, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	shrq	$0x8, %rsi
               	xorl	%ecx, %ecx
               	leaq	0x8(%rcx), %rax
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rax)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x3d, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	shrq	$0x8, %rsi
               	xorl	%ecx, %ecx
               	leaq	0x10(%rcx), %rax
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rax)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x3d, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	shrq	$0x8, %rsi
               	xorl	%ecx, %ecx
               	leaq	0x18(%rcx), %rax
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rax)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	xorl	%edx, %edx
               	vmovups	(%rbx), %ymm1
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm2
               	movups	(%rbx), %xmm14
               	movups	%xmm14, -0x70(%rbp)
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0xa0(%rbp)
               	vmovdqa	%xmm2, %xmm14
               	movups	%xmm14, -0xb0(%rbp)
               	vpsllvd	%ymm0, %ymm1, %ymm3
               	vmovups	%ymm3, (%rsp)
               	vmovaps	%ymm1, %ymm14
               	vmovups	%ymm14, -0x90(%rbp)
               	vmovaps	%ymm0, %ymm14
               	vmovups	%ymm14, -0xd0(%rbp)
               	vmovaps	%ymm2, %ymm14
               	vmovups	%ymm14, -0xf0(%rbp)
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	movzbq	(%rbx,%rax), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	-0x60(%rbp,%rax), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	xorl	%edx, %edx
               	shlxq	%rcx, %rax, %rax
               	cmpq	$0x20, %rcx
               	cmovbq	%rax, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x4(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %r8
               	movzbq	-0x60(%rbp,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	xorl	%edx, %edx
               	shlxq	%rcx, %rax, %rax
               	cmpq	$0x20, %rcx
               	cmovbq	%rax, %rdx
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x20(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x8(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %r8
               	movzbq	-0x60(%rbp,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	xorl	%edx, %edx
               	shlxq	%rcx, %rax, %rax
               	cmpq	$0x20, %rcx
               	cmovbq	%rax, %rdx
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x20(%rbp,%rdi)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0xc(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %r8
               	movzbq	-0x60(%rbp,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	xorl	%edx, %edx
               	shlxq	%rcx, %rax, %rax
               	cmpq	$0x20, %rcx
               	cmovbq	%rax, %rdx
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x20(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x10(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %r8
               	movzbq	-0x60(%rbp,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	xorl	%edx, %edx
               	shlxq	%rcx, %rax, %rax
               	cmpq	$0x20, %rcx
               	cmovbq	%rax, %rdx
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x20(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x14(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x14(%rax), %r8
               	movzbq	-0x60(%rbp,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	xorl	%edx, %edx
               	shlxq	%rcx, %rax, %rax
               	cmpq	$0x20, %rcx
               	cmovbq	%rax, %rdx
               	xorl	%eax, %eax
               	leaq	0x14(%rax), %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x20(%rbp,%rdi)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x18(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x18(%rax), %r8
               	movzbq	-0x60(%rbp,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	xorl	%edx, %edx
               	shlxq	%rcx, %rax, %rax
               	cmpq	$0x20, %rcx
               	cmovbq	%rax, %rdx
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x20(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x1c(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x1c(%rax), %r8
               	movzbq	-0x60(%rbp,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	xorl	%edx, %edx
               	shlxq	%rcx, %rax, %rax
               	cmpq	$0x20, %rcx
               	cmovbq	%rax, %rdx
               	xorl	%eax, %eax
               	leaq	0x1c(%rax), %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x20(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %r12
               	cmovneq	%rcx, %r12
               	vmovups	-0x90(%rbp), %ymm14
               	vmovups	-0xd0(%rbp), %ymm15
               	vpsrlvd	%ymm15, %ymm14, %ymm0
               	vmovups	%ymm0, (%rsp)
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	movzbq	(%rbx,%rax), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	-0x60(%rbp,%rax), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	xorl	%edx, %edx
               	shrxq	%rcx, %rax, %rax
               	cmpq	$0x20, %rcx
               	cmovbq	%rax, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x4(%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	orq	%rcx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %r8
               	movzbq	-0x60(%rbp,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	%edx, %eax
               	xorl	%edx, %edx
               	shrxq	%rcx, %rax, %rax
               	cmpq	$0x20, %rcx
               	cmovbq	%rax, %rdx
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x20(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	vmovups	-0x90(%rbp), %ymm14
               	vmovups	-0xd0(%rbp), %ymm15
               	vpsravd	%ymm15, %ymm14, %ymm0
               	vmovups	%ymm0, (%rsp)
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	movl	$0x1, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	movl	$0x1, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x1, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	movl	$0x1, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	movl	$0x1, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	movl	$0x1, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	vmovups	-0x90(%rbp), %ymm14
               	vmovups	-0xf0(%rbp), %ymm15
               	vpsllvq	%ymm15, %ymm14, %ymm0
               	vmovups	%ymm0, (%rsp)
               	movq	%rbx, %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x8, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x8, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x3, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	vmovups	-0x90(%rbp), %ymm14
               	vmovups	-0xf0(%rbp), %ymm15
               	vpsrlvq	%ymm15, %ymm14, %ymm0
               	vmovups	%ymm0, (%rsp)
               	movq	%rbx, %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x8, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x8, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x3, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	movups	-0x70(%rbp), %xmm14
               	movups	-0xa0(%rbp), %xmm15
               	vpsllvd	%xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	movups	-0x70(%rbp), %xmm14
               	movups	-0xa0(%rbp), %xmm15
               	vpsrlvd	%xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	movups	-0x70(%rbp), %xmm14
               	movups	-0xa0(%rbp), %xmm15
               	vpsravd	%xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	movl	$0x1, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	movl	$0x1, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	movups	-0x70(%rbp), %xmm14
               	movups	-0xb0(%rbp), %xmm15
               	vpsllvq	%xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	movq	%rbx, %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	movups	-0x70(%rbp), %xmm14
               	movups	-0xb0(%rbp), %xmm15
               	vpsrlvq	%xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	movq	%rbx, %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rbx, %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %ecx
               	testq	%rax, %rax
               	cmoveq	%r12, %rcx
               	movq	%rcx, %rax
               	leaq	-0x110(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	vzeroupper
               	leave
               	retq
               	shrq	$0x8, %rsi
               	movabsq	$0x3a83a83a83a83a9, %rcx # imm = 0x3A83A83A83A83A9
               	movq	%rsi, %rax
               	mulq	%rcx
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rsi
               	jmp	<addr>
               	shrq	$0x8, %rsi
               	movabsq	$0x3a83a83a83a83a9, %rcx # imm = 0x3A83A83A83A83A9
               	movq	%rsi, %rax
               	mulq	%rcx
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rsi
               	jmp	<addr>
               	shrq	$0x8, %rsi
               	movabsq	$0x3a83a83a83a83a9, %rcx # imm = 0x3A83A83A83A83A9
               	movq	%rsi, %rax
               	mulq	%rcx
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rsi
               	jmp	<addr>
               	shrq	$0x8, %rsi
               	movabsq	$0x3a83a83a83a83a9, %rcx # imm = 0x3A83A83A83A83A9
               	movq	%rsi, %rax
               	mulq	%rcx
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rsi
               	jmp	<addr>
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rcx
               	jmp	<addr>
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rcx
               	jmp	<addr>
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rcx
               	jmp	<addr>
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rcx
               	jmp	<addr>
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rcx
               	jmp	<addr>
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rcx
               	jmp	<addr>
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rcx
               	jmp	<addr>
               	shrq	$0x8, %rcx
               	movabsq	$0x3a83a83a83a83a9, %rsi # imm = 0x3A83A83A83A83A9
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x46, %rdx, %rax
               	subq	%rax, %rcx
               	jmp	<addr>

<check_shuffles>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
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
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x1c(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x18(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x14(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x14(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x1c(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufd	$0x1b, %ymm14, %ymm0    # ymm0 = ymm14[3,2,1,0,7,6,5,4]
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%r13b
               	movzbq	%r13b, %r13
               	xorl	%r9d, %r9d
               	movq	%r9, %rdx
               	andq	$0x8, %rdx
               	movq	%r9, %rax
               	andq	$0x7, %rax
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%r9, %rdx
               	xorl	%ecx, %ecx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rbx,%rdi), %rdi
               	orq	%rdi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r9, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r8
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	jmp	<addr>
               	leaq	0x4(%rdx), %rcx
               	movl	$0x1b, %edx
               	subq	$0x4, %rax
               	shlq	%rax
               	sarxq	%rax, %rdx, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rdx
               	jmp	<addr>
               	incq	%r9
               	nopl	(%rax)
               	cmpl	$0x10, %r9d
               	jl	<addr>
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufhw	$0x1b, %ymm14, %ymm0    # ymm0 = ymm14[0,1,2,3,7,6,5,4,8,9,10,11,15,14,13,12]
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
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
               	xorl	%r9d, %r9d
               	movq	%r9, %rdx
               	andq	$0x8, %rdx
               	movq	%r9, %rax
               	andq	$0x7, %rax
               	nopl	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%r9, %rdx
               	xorl	%ecx, %ecx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rbx,%rdi), %rdi
               	orq	%rdi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r9, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r8
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	jmp	<addr>
               	movl	$0x1b, %ecx
               	shlq	%rax
               	sarxq	%rax, %rcx, %rax
               	andq	$0x3, %rax
               	addq	%rax, %rdx
               	jmp	<addr>
               	incq	%r9
               	cmpl	$0x10, %r9d
               	jl	<addr>
               	vmovups	-0x60(%rbp), %ymm14
               	vpshuflw	$0x1b, %ymm14, %ymm0    # ymm0 = ymm14[3,2,1,0,4,5,6,7,11,10,9,8,12,13,14,15]
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
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
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x14(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x1c(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufd	$0x0, %ymm14, %ymm0     # ymm0 = ymm14[0,0,0,0,4,4,4,4]
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
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
               	xorl	%r9d, %r9d
               	movq	%r9, %rdx
               	andq	$0x8, %rdx
               	movq	%r9, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%r9, %rdx
               	xorl	%ecx, %ecx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rbx,%rdi), %rdi
               	orq	%rdi, %rcx
               	decq	%rax
               	nopl	(%rax,%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r9, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r8
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	jmp	<addr>
               	leaq	0x4(%rdx), %rcx
               	xorl	%edx, %edx
               	subq	$0x4, %rax
               	shlq	%rax
               	sarxq	%rax, %rdx, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rdx
               	jmp	<addr>
               	incq	%r9
               	cmpl	$0x10, %r9d
               	jl	<addr>
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufhw	$0x0, %ymm14, %ymm0     # ymm0 = ymm14[0,1,2,3,4,4,4,4,8,9,10,11,12,12,12,12]
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
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
               	xorl	%r9d, %r9d
               	movq	%r9, %rdx
               	andq	$0x8, %rdx
               	movq	%r9, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%r9, %rdx
               	xorl	%ecx, %ecx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rbx,%rdi), %rdi
               	orq	%rdi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r9, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r8
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%r8)
               	incq	%rax
               	nop
               	cmpl	$0x2, %eax
               	jl	<addr>
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	shlq	%rax
               	sarxq	%rax, %rcx, %rax
               	andq	$0x3, %rax
               	addq	%rax, %rdx
               	jmp	<addr>
               	incq	%r9
               	nopl	(%rax)
               	cmpl	$0x10, %r9d
               	jl	<addr>
               	vmovups	-0x60(%rbp), %ymm14
               	vpshuflw	$0x0, %ymm14, %ymm0     # ymm0 = ymm14[0,0,0,0,4,5,6,7,8,8,8,8,12,13,14,15]
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
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
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x14(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x14(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x18(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x1c(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x1c(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufd	$0xe4, %ymm14, %ymm0    # ymm0 = ymm14[0,1,2,3,4,5,6,7]
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%r13, %r14
               	orq	%rax, %r14
               	xorl	%r13d, %r13d
               	jmp	<addr>
               	movq	%rbx, %rdi
               	movl	$0x2, %esi
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x2, %esi
               	vzeroupper
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x10, %r13d
               	jge	<addr>
               	movq	%r13, %rdx
               	andq	$0x8, %rdx
               	movq	%r13, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%r13, %rdx
               	jmp	<addr>
               	leaq	0x4(%rdx), %rcx
               	movl	$0xe4, %edx
               	subq	$0x4, %rax
               	shlq	%rax
               	sarxq	%rax, %rdx, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rdx
               	jmp	<addr>
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufhw	$0xe4, %ymm14, %ymm0    # ymm0 = ymm14[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
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
               	xorl	%r13d, %r13d
               	jmp	<addr>
               	movq	%rbx, %rdi
               	movl	$0x2, %esi
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x2, %esi
               	vzeroupper
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x10, %r13d
               	jge	<addr>
               	movq	%r13, %rdx
               	andq	$0x8, %rdx
               	movq	%r13, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%r13, %rdx
               	nopl	(%rax)
               	jmp	<addr>
               	movl	$0xe4, %ecx
               	shlq	%rax
               	sarxq	%rax, %rcx, %rax
               	andq	$0x3, %rax
               	addq	%rax, %rdx
               	jmp	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpshuflw	$0xe4, %ymm14, %ymm0    # ymm0 = ymm14[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	xorl	%ecx, %ecx
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
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	xorl	%r13d, %r13d
               	jmp	<addr>
               	movq	%rbx, %rdi
               	movl	$0x2, %esi
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x2, %esi
               	vzeroupper
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x10, %r13d
               	jge	<addr>
               	movq	%r13, %rdx
               	andq	$0x8, %rdx
               	movq	%r13, %rax
               	andq	$0x7, %rax
               	nopl	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%r13, %rdx
               	jmp	<addr>
               	leaq	0x4(%rdx), %rcx
               	movl	$0x93, %edx
               	subq	$0x4, %rax
               	shlq	%rax
               	sarxq	%rax, %rdx, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rdx
               	jmp	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufhw	$0x93, %ymm14, %ymm0    # ymm0 = ymm14[0,1,2,3,7,4,5,6,8,9,10,11,15,12,13,14]
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	xorl	%r13d, %r13d
               	jmp	<addr>
               	movq	%rbx, %rdi
               	movl	$0x2, %esi
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x2, %esi
               	vzeroupper
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x10, %r13d
               	jge	<addr>
               	movq	%r13, %rdx
               	andq	$0x8, %rdx
               	movq	%r13, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%r13, %rdx
               	jmp	<addr>
               	movl	$0x93, %ecx
               	shlq	%rax
               	sarxq	%rax, %rcx, %rax
               	andq	$0x3, %rax
               	addq	%rax, %rdx
               	jmp	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpshuflw	$0x93, %ymm14, %ymm0    # ymm0 = ymm14[3,0,1,2,4,5,6,7,11,8,9,10,12,13,14,15]
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x7, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x6, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	movl	$0x5, %edx
               	xorl	%ecx, %ecx
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
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	xorl	%r13d, %r13d
               	jmp	<addr>
               	movq	%rbx, %rdi
               	movl	$0x2, %esi
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x2, %esi
               	vzeroupper
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x10, %r13d
               	jge	<addr>
               	movq	%r13, %rdx
               	andq	$0x8, %rdx
               	movq	%r13, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%r13, %rdx
               	jmp	<addr>
               	leaq	0x4(%rdx), %rcx
               	movl	$0x4e, %edx
               	subq	$0x4, %rax
               	shlq	%rax
               	sarxq	%rax, %rdx, %rax
               	andq	$0x3, %rax
               	leaq	(%rcx,%rax), %rdx
               	jmp	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpshufhw	$0x4e, %ymm14, %ymm0    # ymm0 = ymm14[0,1,2,3,6,7,4,5,8,9,10,11,14,15,12,13]
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	xorl	%r13d, %r13d
               	jmp	<addr>
               	movq	%rbx, %rdi
               	movl	$0x2, %esi
               	xorl	%ecx, %ecx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x2, %esi
               	vzeroupper
               	callq	<addr>
               	incq	%r13
               	cmpl	$0x10, %r13d
               	jge	<addr>
               	movq	%r13, %rdx
               	andq	$0x8, %rdx
               	movq	%r13, %rax
               	andq	$0x7, %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%r13, %rdx
               	jmp	<addr>
               	movl	$0x4e, %ecx
               	shlq	%rax
               	sarxq	%rax, %rcx, %rax
               	andq	$0x3, %rax
               	addq	%rax, %rdx
               	jmp	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpshuflw	$0x4e, %ymm14, %ymm0    # ymm0 = ymm14[2,3,0,1,4,5,6,7,10,11,8,9,12,13,14,15]
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%r14, %r13
               	orq	%rax, %r13
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	(%rdx,%rax), %rcx
               	movzbq	(%r12,%rcx), %rdi
               	movb	%dil, -0x40(%rbp,%rcx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	nopl	(%rax)
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	-0x80(%rbp), %ymm15
               	vpalignr	$0x0, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%al, -0x40(%rbp,%rdi)
               	movq	%rcx, %rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rcx
               	leaq	(%rdx,%rax), %rdi
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	leaq	(%rdx,%rcx), %rax
               	movzbq	(%r12,%rax), %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rax
               	subq	$0x10, %rax
               	movzbq	(%rbx,%rax), %rax
               	jmp	<addr>
               	addq	$0x10, %rdx
               	nopl	(%rax)
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	-0x80(%rbp), %ymm15
               	vpalignr	$0x1, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],ymm14[0],ymm15[17,18,19,20,21,22,23,24,25,26,27,28,29,30,31],ymm14[16]
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	0x7(%rax), %rcx
               	leaq	(%rdx,%rax), %rdi
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	addq	%rdx, %rcx
               	movzbq	(%r12,%rcx), %rcx
               	jmp	<addr>
               	addq	%rdx, %rcx
               	subq	$0x10, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	jmp	<addr>
               	addq	$0x10, %rdx
               	nopw	(%rax,%rax)
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	-0x80(%rbp), %ymm15
               	vpalignr	$0x7, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[7,8,9,10,11,12,13,14,15],ymm14[0,1,2,3,4,5,6],ymm15[23,24,25,26,27,28,29,30,31],ymm14[16,17,18,19,20,21,22]
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	0xf(%rax), %rcx
               	leaq	(%rdx,%rax), %rdi
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	addq	%rdx, %rcx
               	movzbq	(%r12,%rcx), %rcx
               	jmp	<addr>
               	addq	%rdx, %rcx
               	subq	$0x10, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	jmp	<addr>
               	addq	$0x10, %rdx
               	nopw	(%rax,%rax)
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	-0x80(%rbp), %ymm15
               	vpalignr	$0xf, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[15],ymm14[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14],ymm15[31],ymm14[16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%r13, %r12
               	orq	%rax, %r12
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rdx
               	leaq	(%rcx,%rax), %rdi
               	addq	%rcx, %rdx
               	subq	$0x10, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	nop
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
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%esi, %esi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movb	%dl, -0x40(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	0x11(%rax), %rdx
               	leaq	(%rsi,%rax), %r8
               	cmpl	$0x20, %edx
               	jge	<addr>
               	addq	%rsi, %rdx
               	subq	$0x10, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	addq	$0x10, %rsi
               	nop
               	cmpl	$0x20, %esi
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	-0x80(%rbp), %ymm15
               	vpalignr	$0x11, %ymm15, %ymm14, %ymm0 # ymm0 = ymm14[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,0]
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%esi, %esi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movb	%dl, -0x40(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	0x1f(%rax), %rdx
               	leaq	(%rsi,%rax), %r8
               	nopw	(%rax,%rax)
               	cmpl	$0x20, %edx
               	jge	<addr>
               	addq	%rsi, %rdx
               	subq	$0x10, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	addq	$0x10, %rsi
               	nopl	(%rax)
               	cmpl	$0x20, %esi
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	-0x80(%rbp), %ymm15
               	vpalignr	$0x1f, %ymm15, %ymm14, %ymm0 # ymm0 = ymm14[15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	(%rdx,%rax), %rdi
               	movb	%cl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	nopw	(%rax,%rax)
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	-0x80(%rbp), %ymm15
               	vpalignr	$0x20, %ymm15, %ymm14, %ymm0 # ymm0 = ymm14[16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	(%rdx,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rdi
               	movb	%dil, -0x40(%rbp,%rcx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	nopw	(%rax,%rax)
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpslldq	$0x0, %ymm14, %ymm0     # ymm0 = ymm14[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	(%rdx,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rdi
               	movb	%dil, -0x40(%rbp,%rcx)
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
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edi, %edi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movb	%dl, -0x40(%rbp,%rsi)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	(%rdi,%rax), %rsi
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	-0x3(%rsi), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	nopl	(%rax)
               	jmp	<addr>
               	addq	$0x10, %rdi
               	cmpl	$0x20, %edi
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpslldq	$0x3, %ymm14, %ymm0     # ymm0 = zero,zero,zero,ymm14[0,1,2,3,4,5,6,7,8,9,10,11,12],zero,zero,zero,ymm14[16,17,18,19,20,21,22,23,24,25,26,27,28]
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edi, %edi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movb	%dl, -0x40(%rbp,%rsi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	(%rdi,%rax), %rsi
               	leaq	0x3(%rax), %rdx
               	nopw	(%rax,%rax)
               	cmpl	$0x10, %edx
               	jge	<addr>
               	leaq	0x3(%rsi), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	addq	$0x10, %rdi
               	nopl	(%rax)
               	cmpl	$0x20, %edi
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpsrldq	$0x3, %ymm14, %ymm0     # ymm0 = ymm14[3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero,ymm14[19,20,21,22,23,24,25,26,27,28,29,30,31],zero,zero,zero
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edi, %edi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	nop
               	jmp	<addr>
               	movb	%dl, -0x40(%rbp,%rsi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	(%rdi,%rax), %rsi
               	cmpl	$0xf, %eax
               	jl	<addr>
               	leaq	-0xf(%rsi), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	addq	$0x10, %rdi
               	cmpl	$0x20, %edi
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpslldq	$0xf, %ymm14, %ymm0     # ymm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,ymm14[0],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,ymm14[16]
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	xorl	%edi, %edi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movb	%dl, -0x40(%rbp,%rsi)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	(%rdi,%rax), %rsi
               	leaq	0xf(%rax), %rdx
               	nop
               	cmpl	$0x10, %edx
               	jge	<addr>
               	leaq	0xf(%rsi), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	addq	$0x10, %rdi
               	nopl	(%rax)
               	cmpl	$0x20, %edi
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpsrldq	$0xf, %ymm14, %ymm0     # ymm0 = ymm14[15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,ymm14[31],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%r12, %rbx
               	orq	%rax, %rbx
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	(%rdx,%rax), %rdi
               	movb	%cl, -0x40(%rbp,%rdi)
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
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	(%rdx,%rax), %rdi
               	movb	%cl, -0x40(%rbp,%rdi)
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	addq	$0x10, %rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	(%rsp), %r9
               	vmovups	-0x60(%rbp), %ymm14
               	vpsrldq	$0x10, %ymm14, %ymm0    # ymm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	vmovups	%ymm0, (%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rbx, %rax
               	movl	$0x8, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq

<check_blends>:
               	subq	$0xa8, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	vmovups	(%rbx), %ymm14
               	vmovups	%ymm14, 0x60(%rsp)
               	vmovups	(%r12), %ymm14
               	vmovups	%ymm14, 0x40(%rsp)
               	movups	(%rbx), %xmm14
               	movups	%xmm14, 0x30(%rsp)
               	movups	(%r12), %xmm14
               	movups	%xmm14, 0x20(%rsp)
               	xorl	%r10d, %r10d
               	xorl	%ecx, %ecx
               	movq	%r10, %rax
               	andq	$0x7, %rax
               	sarxq	%rax, %rcx, %rax
               	testb	$0x1, %al
               	movq	%rbx, %rdi
               	cmovneq	%r12, %rdi
               	movq	%r10, %r8
               	shlq	%r8
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	nopw	(%rax,%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r10, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r9
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x80(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r10
               	nopw	%cs:(%rax,%rax)
               	cmpl	$0x10, %r10d
               	jl	<addr>
               	vmovups	0x60(%rsp), %ymm14
               	vmovups	0x40(%rsp), %ymm15
               	vpblendw	$0x0, %ymm15, %ymm14, %ymm0 # ymm0 = ymm14[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	xorl	%r10d, %r10d
               	xorl	%ecx, %ecx
               	sarxq	%r10, %rcx, %rax
               	testb	$0x1, %al
               	movq	%rbx, %rdi
               	cmovneq	%r12, %rdi
               	movq	%r10, %r8
               	shlq	$0x2, %r8
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r10, %rdi
               	shlq	$0x2, %rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r9
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x80(%rsp,%r9)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%r10
               	cmpl	$0x8, %r10d
               	jl	<addr>
               	vmovups	0x60(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm2
               	vmovups	0x40(%rsp), %ymm1
               	vmovdqa	%xmm1, %xmm3
               	vblendps	$0x0, %xmm3, %xmm2, %xmm2 # xmm2 = xmm2[0,1,2,3]
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vblendps	$0x0, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0,1,2,3]
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm1
               	vpextrq	$0x1, %xmm2, %rax
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x20, %edx
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vblendps	$0x0, %xmm15, %xmm14, %xmm0 # xmm0 = xmm14[0,1,2,3]
               	movups	%xmm0, 0xb0(%rsp)
               	leaq	0xb0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x10, %edx
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
               	xorl	%r10d, %r10d
               	movl	$0xff, %eax
               	movq	%r10, %rcx
               	andq	$0x7, %rcx
               	sarxq	%rcx, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %rdi
               	cmovneq	%r12, %rdi
               	xorl	%ecx, %ecx
               	movq	%r10, %r8
               	shlq	%r8
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r10, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r9
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x80(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r10
               	nopw	(%rax,%rax)
               	cmpl	$0x10, %r10d
               	jl	<addr>
               	vmovups	0x60(%rsp), %ymm14
               	vmovups	0x40(%rsp), %ymm15
               	vpblendw	$0xff, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x20, %edx
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
               	xorl	%r10d, %r10d
               	movl	$0xff, %eax
               	sarxq	%r10, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %rdi
               	cmovneq	%r12, %rdi
               	xorl	%ecx, %ecx
               	movq	%r10, %r8
               	shlq	$0x2, %r8
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r10, %rdi
               	shlq	$0x2, %rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r9
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x80(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%r10
               	cmpl	$0x8, %r10d
               	jl	<addr>
               	vmovups	0x60(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm2
               	vmovups	0x40(%rsp), %ymm1
               	vmovdqa	%xmm1, %xmm3
               	vblendps	$0xf, %xmm3, %xmm2, %xmm2 # xmm2 = xmm3[0,1,2,3]
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vblendps	$0xf, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[0,1,2,3]
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm1
               	vpextrq	$0x1, %xmm2, %rax
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x20, %edx
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vblendps	$0xf, %xmm15, %xmm14, %xmm0 # xmm0 = xmm15[0,1,2,3]
               	movups	%xmm0, 0xb0(%rsp)
               	leaq	0xb0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x10, %edx
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
               	xorl	%r10d, %r10d
               	movl	$0xa5, %eax
               	movq	%r10, %rcx
               	andq	$0x7, %rcx
               	sarxq	%rcx, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %rdi
               	cmovneq	%r12, %rdi
               	xorl	%ecx, %ecx
               	movq	%r10, %r8
               	shlq	%r8
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r10, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r9
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x80(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r10
               	nopl	(%rax)
               	cmpl	$0x10, %r10d
               	jl	<addr>
               	vmovups	0x60(%rsp), %ymm14
               	vmovups	0x40(%rsp), %ymm15
               	vpblendw	$0xa5, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[0],ymm14[1],ymm15[2],ymm14[3,4],ymm15[5],ymm14[6],ymm15[7,8],ymm14[9],ymm15[10],ymm14[11,12],ymm15[13],ymm14[14],ymm15[15]
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x20, %edx
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
               	xorl	%r10d, %r10d
               	movl	$0xa5, %eax
               	sarxq	%r10, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %rdi
               	cmovneq	%r12, %rdi
               	xorl	%ecx, %ecx
               	movq	%r10, %r8
               	shlq	$0x2, %r8
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r10, %rdi
               	shlq	$0x2, %rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r9
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x80(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%r10
               	cmpl	$0x8, %r10d
               	jl	<addr>
               	vmovups	0x60(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm2
               	vmovups	0x40(%rsp), %ymm1
               	vmovdqa	%xmm1, %xmm3
               	vblendps	$0x5, %xmm3, %xmm2, %xmm2 # xmm2 = xmm3[0],xmm2[1],xmm3[2],xmm2[3]
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vblendps	$0xa, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[1],xmm0[2],xmm1[3]
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm1
               	vpextrq	$0x1, %xmm2, %rax
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x20, %edx
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vblendps	$0x5, %xmm15, %xmm14, %xmm0 # xmm0 = xmm15[0],xmm14[1],xmm15[2],xmm14[3]
               	movups	%xmm0, 0xb0(%rsp)
               	leaq	0xb0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x10, %edx
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
               	xorl	%r10d, %r10d
               	movl	$0x5a, %eax
               	movq	%r10, %rcx
               	andq	$0x7, %rcx
               	sarxq	%rcx, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %rdi
               	cmovneq	%r12, %rdi
               	xorl	%ecx, %ecx
               	movq	%r10, %r8
               	shlq	%r8
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r10, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r9
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x80(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r10
               	nopl	(%rax)
               	cmpl	$0x10, %r10d
               	jl	<addr>
               	vmovups	0x60(%rsp), %ymm14
               	vmovups	0x40(%rsp), %ymm15
               	vpblendw	$0x5a, %ymm15, %ymm14, %ymm0 # ymm0 = ymm14[0],ymm15[1],ymm14[2],ymm15[3,4],ymm14[5],ymm15[6],ymm14[7,8],ymm15[9],ymm14[10],ymm15[11,12],ymm14[13],ymm15[14],ymm14[15]
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x20, %edx
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
               	xorl	%r10d, %r10d
               	movl	$0x5a, %eax
               	sarxq	%r10, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %rdi
               	cmovneq	%r12, %rdi
               	xorl	%ecx, %ecx
               	movq	%r10, %r8
               	shlq	$0x2, %r8
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r10, %rdi
               	shlq	$0x2, %rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r9
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x80(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%r10
               	cmpl	$0x8, %r10d
               	jl	<addr>
               	vmovups	0x60(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm2
               	vmovups	0x40(%rsp), %ymm1
               	vmovdqa	%xmm1, %xmm3
               	vblendps	$0xa, %xmm3, %xmm2, %xmm2 # xmm2 = xmm2[0],xmm3[1],xmm2[2],xmm3[3]
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vblendps	$0x5, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[0],xmm0[1],xmm1[2],xmm0[3]
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm1
               	vpextrq	$0x1, %xmm2, %rax
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x20, %edx
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vblendps	$0xa, %xmm15, %xmm14, %xmm0 # xmm0 = xmm14[0],xmm15[1],xmm14[2],xmm15[3]
               	movups	%xmm0, 0xb0(%rsp)
               	leaq	0xb0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x10, %edx
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
               	xorl	%r10d, %r10d
               	movl	$0x81, %eax
               	movq	%r10, %rcx
               	andq	$0x7, %rcx
               	sarxq	%rcx, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %rdi
               	cmovneq	%r12, %rdi
               	xorl	%ecx, %ecx
               	movq	%r10, %r8
               	shlq	%r8
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r10, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r9
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x80(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r10
               	nopl	(%rax)
               	cmpl	$0x10, %r10d
               	jl	<addr>
               	vmovups	0x60(%rsp), %ymm14
               	vmovups	0x40(%rsp), %ymm15
               	vpblendw	$0x81, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[0],ymm14[1,2,3,4,5,6],ymm15[7,8],ymm14[9,10,11,12,13,14],ymm15[15]
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x20, %edx
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
               	xorl	%r10d, %r10d
               	movl	$0x81, %eax
               	sarxq	%r10, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %rdi
               	cmovneq	%r12, %rdi
               	xorl	%ecx, %ecx
               	movq	%r10, %r8
               	shlq	$0x2, %r8
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r10, %rdi
               	shlq	$0x2, %rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r9
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x80(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%r10
               	cmpl	$0x8, %r10d
               	jl	<addr>
               	vmovups	0x60(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm2
               	vmovups	0x40(%rsp), %ymm1
               	vmovdqa	%xmm1, %xmm3
               	vblendps	$0x1, %xmm3, %xmm2, %xmm2 # xmm2 = xmm3[0],xmm2[1,2,3]
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vblendps	$0x8, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0,1,2],xmm1[3]
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm1
               	vpextrq	$0x1, %xmm2, %rax
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x20, %edx
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vblendps	$0x1, %xmm15, %xmm14, %xmm0 # xmm0 = xmm15[0],xmm14[1,2,3]
               	movups	%xmm0, 0xb0(%rsp)
               	leaq	0xb0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x10, %edx
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
               	xorl	%r10d, %r10d
               	movl	$0xf, %eax
               	movq	%r10, %rcx
               	andq	$0x7, %rcx
               	sarxq	%rcx, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %rdi
               	cmovneq	%r12, %rdi
               	xorl	%ecx, %ecx
               	movq	%r10, %r8
               	shlq	%r8
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r10, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r9
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x80(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r10
               	nopl	(%rax)
               	cmpl	$0x10, %r10d
               	jl	<addr>
               	vmovups	0x60(%rsp), %ymm14
               	vmovups	0x40(%rsp), %ymm15
               	vpblendw	$0xf, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[0,1,2,3],ymm14[4,5,6,7],ymm15[8,9,10,11],ymm14[12,13,14,15]
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x20, %edx
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
               	xorl	%r10d, %r10d
               	movl	$0xf, %eax
               	sarxq	%r10, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %rdi
               	cmovneq	%r12, %rdi
               	xorl	%ecx, %ecx
               	movq	%r10, %r8
               	shlq	$0x2, %r8
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rax), %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r10, %rdi
               	shlq	$0x2, %rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r9
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x80(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%r10
               	cmpl	$0x8, %r10d
               	jl	<addr>
               	vmovups	0x60(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm2
               	vmovups	0x40(%rsp), %ymm1
               	vmovdqa	%xmm1, %xmm3
               	vblendps	$0xf, %xmm3, %xmm2, %xmm2 # xmm2 = xmm3[0,1,2,3]
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vblendps	$0x0, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0,1,2,3]
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm1
               	vpextrq	$0x1, %xmm2, %rax
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x20, %edx
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vblendps	$0xf, %xmm15, %xmm14, %xmm0 # xmm0 = xmm15[0,1,2,3]
               	movups	%xmm0, 0xb0(%rsp)
               	leaq	0xb0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x10, %edx
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
               	jmp	<addr>
               	movb	%cl, 0x80(%rsp,%rax)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x20, %eax
               	jge	<addr>
               	movzbq	(%r13,%rax), %rcx
               	testb	$-0x80, %cl
               	je	<addr>
               	movzbq	(%r12,%rax), %rcx
               	jmp	<addr>
               	movzbq	(%rbx,%rax), %rcx
               	nopl	(%rax)
               	jmp	<addr>
               	vmovups	(%r13), %ymm0
               	vmovups	0x60(%rsp), %ymm14
               	vpblendvb	%ymm0, 0x40(%rsp), %ymm14, %ymm0
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movl	$0x20, %edx
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
               	movl	$0x10, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	addq	$0xa8, %rsp
               	retq

<check_extensions>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x1a0, %rsp            # imm = 0x1A0
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movups	(%rbx), %xmm0
               	pmovsxbw	%xmm0, %xmm1
               	movapd	%xmm0, %xmm2
               	psrldq	$0x8, %xmm2             # xmm2 = xmm2[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	pmovsxbw	%xmm2, %xmm2
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm2, %rax
               	movapd	%xmm3, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm1, %ymm1
               	vmovups	%ymm1, (%rsp)
               	pmovsxbd	%xmm0, %xmm1
               	movapd	%xmm0, %xmm2
               	psrldq	$0x4, %xmm2             # xmm2 = xmm2[4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero,zero
               	pmovsxbd	%xmm2, %xmm2
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm2, %rax
               	movapd	%xmm3, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm1, %ymm1
               	vmovups	%ymm1, 0x20(%rsp)
               	pmovsxbq	%xmm0, %xmm1
               	movapd	%xmm0, %xmm2
               	psrldq	$0x2, %xmm2             # xmm2 = xmm2[2,3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero
               	pmovsxbq	%xmm2, %xmm2
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm2, %rax
               	movapd	%xmm3, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm1, %ymm1
               	vmovups	%ymm1, 0x40(%rsp)
               	pmovsxwd	%xmm0, %xmm1
               	movapd	%xmm0, %xmm2
               	psrldq	$0x8, %xmm2             # xmm2 = xmm2[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	pmovsxwd	%xmm2, %xmm2
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm2, %rax
               	movapd	%xmm3, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm1, %ymm1
               	vmovups	%ymm1, 0x60(%rsp)
               	pmovsxwq	%xmm0, %xmm1
               	movapd	%xmm0, %xmm2
               	psrldq	$0x4, %xmm2             # xmm2 = xmm2[4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero,zero
               	pmovsxwq	%xmm2, %xmm2
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm2, %rax
               	movapd	%xmm3, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm1, %ymm1
               	vmovups	%ymm1, 0x80(%rsp)
               	pmovsxdq	%xmm0, %xmm1
               	movapd	%xmm0, %xmm2
               	psrldq	$0x8, %xmm2             # xmm2 = xmm2[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	pmovsxdq	%xmm2, %xmm2
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm2, %rax
               	movapd	%xmm3, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm1, %ymm1
               	vmovups	%ymm1, 0xa0(%rsp)
               	pmovzxbw	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
               	movapd	%xmm0, %xmm2
               	psrldq	$0x8, %xmm2             # xmm2 = xmm2[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	pmovzxbw	%xmm2, %xmm2            # xmm2 = xmm2[0],zero,xmm2[1],zero,xmm2[2],zero,xmm2[3],zero,xmm2[4],zero,xmm2[5],zero,xmm2[6],zero,xmm2[7],zero
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm2, %rax
               	movapd	%xmm3, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm1, %ymm1
               	vmovups	%ymm1, 0xc0(%rsp)
               	pmovzxbd	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero
               	movapd	%xmm0, %xmm2
               	psrldq	$0x4, %xmm2             # xmm2 = xmm2[4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero,zero
               	pmovzxbd	%xmm2, %xmm2            # xmm2 = xmm2[0],zero,zero,zero,xmm2[1],zero,zero,zero,xmm2[2],zero,zero,zero,xmm2[3],zero,zero,zero
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm2, %rax
               	movapd	%xmm3, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm1, %ymm1
               	vmovups	%ymm1, 0xe0(%rsp)
               	pmovzxbq	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,zero,zero,zero,zero,zero,zero,xmm0[1],zero,zero,zero,zero,zero,zero,zero
               	movapd	%xmm0, %xmm2
               	psrldq	$0x2, %xmm2             # xmm2 = xmm2[2,3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero
               	pmovzxbq	%xmm2, %xmm2            # xmm2 = xmm2[0],zero,zero,zero,zero,zero,zero,zero,xmm2[1],zero,zero,zero,zero,zero,zero,zero
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm2, %rax
               	movapd	%xmm3, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm1, %ymm1
               	vmovups	%ymm1, 0x100(%rsp)
               	pmovzxwd	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
               	movapd	%xmm0, %xmm2
               	psrldq	$0x8, %xmm2             # xmm2 = xmm2[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	pmovzxwd	%xmm2, %xmm2            # xmm2 = xmm2[0],zero,xmm2[1],zero,xmm2[2],zero,xmm2[3],zero
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm2, %rax
               	movapd	%xmm3, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm1, %ymm1
               	vmovups	%ymm1, 0x120(%rsp)
               	pmovzxwq	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero
               	movapd	%xmm0, %xmm2
               	psrldq	$0x4, %xmm2             # xmm2 = xmm2[4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero,zero
               	pmovzxwq	%xmm2, %xmm2            # xmm2 = xmm2[0],zero,zero,zero,xmm2[1],zero,zero,zero
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm2, %rax
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm2, %rax
               	movapd	%xmm3, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm1, %ymm1
               	vmovups	%ymm1, 0x140(%rsp)
               	pmovzxdq	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,xmm0[1],zero
               	psrldq	$0x8, %xmm0             # xmm0 = xmm0[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	pmovzxdq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero,xmm0[1],zero
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x160(%rsp)
               	xorl	%r12d, %r12d
               	leaq	<rip>, %rcx # <addr>
               	imulq	$0x2aaaaaab, %r12, %rax # imm = 0x2AAAAAAB
               	shrq	$0x20, %rax
               	imulq	$0x6, %rax, %rdx
               	movq	%r12, %rax
               	subq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	xorl	%r11d, %r11d
               	movl	(%rax), %r13d
               	movl	0x4(%rax), %esi
               	leaq	-0x1(%r13), %rdi
               	movq	%r13, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %r14
               	movslq	%eax, %r15
               	movl	$0x20, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %r11d
               	jge	<addr>
               	cmpl	$0x6, %r12d
               	setl	%r10b
               	movzbq	%r10b, %r10
               	xorl	%ecx, %ecx
               	movq	%r13, %rdx
               	imulq	%r11, %rdx
               	movq	%rdi, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %r9
               	movslq	%r9d, %r9
               	movzbq	(%rbx,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%r10, %r10
               	je	<addr>
               	cmpl	$0x8, %r13d
               	jge	<addr>
               	shrxq	%r14, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	shlxq	%r15, %rax, %rax
               	orq	%rax, %rcx
               	movq	%rsi, %r9
               	imulq	%r11, %r9
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	(%r9,%rax), %rdx
               	movslq	%edx, %r10
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%r10)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	%esi, %eax
               	jl	<addr>
               	incq	%r11
               	movl	$0x20, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %r11d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	%r12, %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	0x180(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r12
               	nop
               	cmpl	$0xc, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x70(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x20, %eax
               	leaq	-0x70(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq

<check_mpsadbw>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x88, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	(%rsp), %rax
               	vmovups	(%rbx), %ymm14
               	vmovups	%ymm14, (%rax)
               	movq	(%rbx), %r15
               	movq	0x8(%rbx), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x10(%rbx), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x18(%rbx), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	(%rsp), %rax
               	vmovups	(%r12), %ymm14
               	vmovups	%ymm14, (%rax)
               	movq	(%r12), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	0x8(%r12), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0x10(%r12), %r10
               	movq	%r10, -0x70(%rbp)
               	movq	0x18(%r12), %r10
               	movq	%r10, -0x78(%rbp)
               	xorl	%r14d, %r14d
               	xorl	%r10d, %r10d
               	leaq	(%r14,%r14,2), %rax
               	sarxq	%rax, %r10, %rax
               	movq	%r14, %rdx
               	shlq	$0x4, %rdx
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	$0x2, %rcx
               	andq	$0x1, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %r11
               	andq	$0x3, %rax
               	shlq	$0x2, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	%r14, %r13
               	shlq	$0x3, %r13
               	xorl	%eax, %eax
               	leaq	(%r11,%r10), %rsi
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	(%rdi,%rax), %r8
               	movzbq	(%r12,%r8), %r8
               	subq	%r8, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	testl	%ecx, %ecx
               	cmovlq	%r8, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	(%r13,%r10), %rsi
               	movslq	%edx, %rdx
               	shlq	%rsi
               	xorl	%eax, %eax
               	leaq	(%rsi,%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x40(%rbp,%r9)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r10
               	cmpl	$0x8, %r10d
               	jl	<addr>
               	incq	%r14
               	cmpl	$0x2, %r14d
               	jl	<addr>
               	vmovq	%r15, %xmm0
               	movq	-0x48(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	movq	-0x60(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x68(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	vmpsadbw	$0x0, %xmm1, %xmm0, %xmm0
               	movq	-0x50(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x58(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	movq	-0x70(%rbp), %r11
               	vmovq	%r11, %xmm2
               	movq	-0x78(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vmpsadbw	$0x0, %xmm2, %xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x80(%rbp)
               	xorl	%r14d, %r14d
               	movl	$0x5, %eax
               	leaq	(%r14,%r14,2), %rcx
               	sarxq	%rcx, %rax, %rax
               	movq	%r14, %rdx
               	shlq	$0x4, %rdx
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	$0x2, %rcx
               	andq	$0x1, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %r11
               	andq	$0x3, %rax
               	shlq	$0x2, %rax
               	leaq	(%rdx,%rax), %rdi
               	xorl	%r10d, %r10d
               	movq	%r14, %r13
               	shlq	$0x3, %r13
               	xorl	%eax, %eax
               	leaq	(%r11,%r10), %rsi
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	(%rdi,%rax), %r8
               	movzbq	(%r12,%r8), %r8
               	subq	%r8, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	testl	%ecx, %ecx
               	cmovlq	%r8, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	(%r13,%r10), %rsi
               	movslq	%edx, %rdx
               	shlq	%rsi
               	xorl	%eax, %eax
               	leaq	(%rsi,%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x40(%rbp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r10
               	nopl	(%rax)
               	cmpl	$0x8, %r10d
               	jl	<addr>
               	incq	%r14
               	cmpl	$0x2, %r14d
               	jl	<addr>
               	vmovq	%r15, %xmm0
               	movq	-0x48(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	movq	-0x60(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x68(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	vmpsadbw	$0x5, %xmm1, %xmm0, %xmm0
               	movq	-0x50(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x58(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	movq	-0x70(%rbp), %r11
               	vmovq	%r11, %xmm2
               	movq	-0x78(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vmpsadbw	$0x0, %xmm2, %xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x80(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x80(%rbp)
               	xorl	%r14d, %r14d
               	movl	$0x2d, %eax
               	leaq	(%r14,%r14,2), %rcx
               	sarxq	%rcx, %rax, %rax
               	movq	%r14, %rdx
               	shlq	$0x4, %rdx
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	$0x2, %rcx
               	andq	$0x1, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %r11
               	andq	$0x3, %rax
               	shlq	$0x2, %rax
               	leaq	(%rdx,%rax), %rdi
               	xorl	%r10d, %r10d
               	movq	%r14, %r13
               	shlq	$0x3, %r13
               	xorl	%eax, %eax
               	leaq	(%r11,%r10), %rsi
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	(%rdi,%rax), %r8
               	movzbq	(%r12,%r8), %r8
               	subq	%r8, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	testl	%ecx, %ecx
               	cmovlq	%r8, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	(%r13,%r10), %rsi
               	movslq	%edx, %rdx
               	shlq	%rsi
               	xorl	%eax, %eax
               	leaq	(%rsi,%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x40(%rbp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r10
               	cmpl	$0x8, %r10d
               	jl	<addr>
               	incq	%r14
               	nopl	(%rax)
               	cmpl	$0x2, %r14d
               	jl	<addr>
               	vmovq	%r15, %xmm0
               	movq	-0x48(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	movq	-0x60(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x68(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	vmpsadbw	$0x2d, %xmm1, %xmm0, %xmm0
               	movq	-0x50(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x58(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	movq	-0x70(%rbp), %r11
               	vmovq	%r11, %xmm2
               	movq	-0x78(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vmpsadbw	$0x5, %xmm2, %xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x80(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x80(%rbp)
               	xorl	%r14d, %r14d
               	movl	$0x3f, %eax
               	leaq	(%r14,%r14,2), %rcx
               	sarxq	%rcx, %rax, %rax
               	movq	%r14, %rdx
               	shlq	$0x4, %rdx
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	$0x2, %rcx
               	andq	$0x1, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %r11
               	andq	$0x3, %rax
               	shlq	$0x2, %rax
               	leaq	(%rdx,%rax), %rdi
               	xorl	%r10d, %r10d
               	movq	%r14, %r13
               	shlq	$0x3, %r13
               	xorl	%eax, %eax
               	leaq	(%r11,%r10), %rsi
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	(%rdi,%rax), %r8
               	movzbq	(%r12,%r8), %r8
               	subq	%r8, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	testl	%ecx, %ecx
               	cmovlq	%r8, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	(%r13,%r10), %rsi
               	movslq	%edx, %rdx
               	shlq	%rsi
               	xorl	%eax, %eax
               	leaq	(%rsi,%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x40(%rbp,%r9)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r10
               	cmpl	$0x8, %r10d
               	jl	<addr>
               	incq	%r14
               	cmpl	$0x2, %r14d
               	jl	<addr>
               	vmovq	%r15, %xmm0
               	movq	-0x48(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	movq	-0x60(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x68(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	vmpsadbw	$0x3f, %xmm1, %xmm0, %xmm0
               	movq	-0x50(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x58(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	movq	-0x70(%rbp), %r11
               	vmovq	%r11, %xmm2
               	movq	-0x78(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vmpsadbw	$0x7, %xmm2, %xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x80(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x80(%rbp)
               	xorl	%r14d, %r14d
               	movl	$0x12, %eax
               	leaq	(%r14,%r14,2), %rcx
               	sarxq	%rcx, %rax, %rax
               	movq	%r14, %rdx
               	shlq	$0x4, %rdx
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	$0x2, %rcx
               	andq	$0x1, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %r11
               	andq	$0x3, %rax
               	shlq	$0x2, %rax
               	leaq	(%rdx,%rax), %rdi
               	xorl	%r10d, %r10d
               	movq	%r14, %r13
               	shlq	$0x3, %r13
               	xorl	%eax, %eax
               	leaq	(%r11,%r10), %rsi
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	(%rdi,%rax), %r8
               	movzbq	(%r12,%r8), %r8
               	subq	%r8, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	testl	%ecx, %ecx
               	cmovlq	%r8, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	nop
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	(%r13,%r10), %rsi
               	movslq	%edx, %rdx
               	shlq	%rsi
               	xorl	%eax, %eax
               	leaq	(%rsi,%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x40(%rbp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r10
               	nopl	(%rax)
               	cmpl	$0x8, %r10d
               	jl	<addr>
               	incq	%r14
               	cmpl	$0x2, %r14d
               	jl	<addr>
               	vmovq	%r15, %xmm0
               	movq	-0x48(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	movq	-0x60(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x68(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	vmpsadbw	$0x12, %xmm1, %xmm0, %xmm0
               	movq	-0x50(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x58(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	movq	-0x70(%rbp), %r11
               	vmovq	%r11, %xmm2
               	movq	-0x78(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vmpsadbw	$0x2, %xmm2, %xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x80(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x80(%rbp)
               	xorl	%r14d, %r14d
               	movl	$0x38, %eax
               	leaq	(%r14,%r14,2), %rcx
               	sarxq	%rcx, %rax, %rax
               	movq	%r14, %rdx
               	shlq	$0x4, %rdx
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	$0x2, %rcx
               	andq	$0x1, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %r11
               	andq	$0x3, %rax
               	shlq	$0x2, %rax
               	leaq	(%rdx,%rax), %rdi
               	xorl	%r10d, %r10d
               	movq	%r14, %r13
               	shlq	$0x3, %r13
               	xorl	%eax, %eax
               	leaq	(%r11,%r10), %rsi
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	(%rdi,%rax), %r8
               	movzbq	(%r12,%r8), %r8
               	subq	%r8, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	testl	%ecx, %ecx
               	cmovlq	%r8, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	(%r13,%r10), %rsi
               	movslq	%edx, %rdx
               	shlq	%rsi
               	xorl	%eax, %eax
               	leaq	(%rsi,%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x40(%rbp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r10
               	cmpl	$0x8, %r10d
               	jl	<addr>
               	incq	%r14
               	nopl	(%rax)
               	cmpl	$0x2, %r14d
               	jl	<addr>
               	vmovq	%r15, %xmm0
               	movq	-0x48(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	movq	-0x60(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x68(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	vmpsadbw	$0x38, %xmm1, %xmm0, %xmm0
               	movq	-0x50(%rbp), %r11
               	vmovq	%r11, %xmm1
               	movq	-0x58(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	movq	-0x70(%rbp), %r11
               	vmovq	%r11, %xmm2
               	movq	-0x78(%rbp), %r11
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vmpsadbw	$0x7, %xmm2, %xmm1, %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, %r10
               	movq	-0x80(%rbp), %rax
               	orq	%r10, %rax
               	movl	$0x40, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq

<check_broadcasts>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movups	(%rbx), %xmm14
               	movups	%xmm14, -0x50(%rbp)
               	xorl	%r12d, %r12d
               	movq	%r12, %r13
               	jmp	<addr>
               	movups	(%rax), %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x10, %edx
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
               	jge	<addr>
               	movl	$0x1, %eax
               	shlxq	%r12, %rax, %rsi
               	xorl	%r11d, %r11d
               	leaq	-0x1(%rsi), %rax
               	movslq	%eax, %rdi
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %r11d
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movq	%rdi, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rsi, %r9
               	imulq	%r11, %r9
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	(%r9,%rax), %rdx
               	movslq	%edx, %r10
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%r10)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	incq	%r11
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %r11d
               	jl	<addr>
               	nopl	(%rax,%rax)
               	testl	%r12d, %r12d
               	jne	<addr>
               	movups	-0x50(%rbp), %xmm14
               	vpextrb	$0x0, %xmm14, %eax
               	movsbq	%al, %rax
               	movsbq	%al, %rax
               	vmovd	%eax, %xmm0
               	vpbroadcastb	%xmm0, %xmm0
               	leaq	0x40(%rsp), %rax
               	movups	%xmm0, 0x40(%rsp)
               	jmp	<addr>
               	cmpl	$0x1, %r12d
               	jne	<addr>
               	movups	-0x50(%rbp), %xmm14
               	vpextrw	$0x0, %xmm14, %eax
               	movswq	%ax, %rax
               	movswq	%ax, %rax
               	vmovd	%eax, %xmm0
               	vpbroadcastw	%xmm0, %xmm0
               	leaq	0x50(%rsp), %rax
               	movups	%xmm0, 0x50(%rsp)
               	nopl	(%rax)
               	jmp	<addr>
               	cmpl	$0x2, %r12d
               	jne	<addr>
               	movups	-0x50(%rbp), %xmm14
               	vmovd	%xmm14, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm0
               	vpbroadcastd	%xmm0, %xmm0
               	leaq	(%rsp), %rax
               	movups	%xmm0, (%rsp)
               	jmp	<addr>
               	movups	-0x50(%rbp), %xmm14
               	vmovq	%xmm14, %rax
               	vmovq	%rax, %xmm0
               	vpbroadcastq	%xmm0, %xmm0
               	leaq	0x20(%rsp), %rax
               	movups	%xmm0, 0x20(%rsp)
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x14(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x1c(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm1
               	vpbroadcastd	%xmm1, %xmm1
               	movups	%xmm1, 0x40(%rsp)
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm0
               	vpbroadcastd	%xmm0, %ymm0
               	vmovups	%ymm0, (%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%r13, %r12
               	orq	%rcx, %r12
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	nopl	(%rax,%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	nopl	(%rax,%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm1
               	vpbroadcastq	%xmm1, %xmm1
               	movups	%xmm1, 0x50(%rsp)
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm0
               	vpbroadcastq	%xmm0, %ymm0
               	vmovups	%ymm0, 0x20(%rsp)
               	leaq	0x50(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %r12
               	leaq	-0x40(%rbp), %rsi
               	vmovups	(%rbx), %xmm14
               	vmovups	%xmm14, (%rsi)
               	leaq	0x10(%rsi), %rax
               	vmovups	(%rbx), %xmm14
               	vmovups	%xmm14, (%rax)
               	movups	-0x50(%rbp), %xmm0
               	vmovdqa	%xmm0, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
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
               	movl	$0x80, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	leaq	-0x70(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	vzeroupper
               	leave
               	retq

<main>:
               	subq	$0xd0, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r15d, %r15d
               	movq	%r15, %r14
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movb	%al, 0x50(%rsp,%rcx)
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rax
               	andq	$0x3, %rax
               	movzbq	(%rsi,%rax), %rax
               	jmp	<addr>
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movb	%al, 0x70(%rsp,%rcx)
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rax
               	andq	$0x3, %rax
               	movzbq	(%rsi,%rax), %rax
               	jmp	<addr>
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	nopl	(%rax)
               	jmp	<addr>
               	movb	%al, 0x90(%rsp,%rcx)
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rax
               	andq	$0x3, %rax
               	movzbq	(%rsi,%rax), %rax
               	jmp	<addr>
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	nop
               	jmp	<addr>
               	vmovups	0x50(%rsp), %ymm14
               	vmovups	%ymm14, 0x30(%rsp)
               	xorl	%r12d, %r12d
               	movq	%r12, %r13
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%r12,4), %rbx
               	movq	%rbx, %r8
               	leaq	0x50(%rsp), %rdi
               	movl	$0x20, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	leaq	0xb0(%rsp), %r9
               	vzeroupper
               	callq	<addr>
               	vmovups	0x30(%rsp), %ymm14
               	vmovq	%rbx, %xmm15
               	vpsllw	%xmm15, %ymm14, %ymm0
               	vmovups	%ymm0, 0xd0(%rsp)
               	leaq	0xd0(%rsp), %rdi
               	leaq	0xb0(%rsp), %rsi
               	movl	$0x20, %edx
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
               	movq	%rbx, %r8
               	leaq	0x50(%rsp), %rdi
               	movl	$0x20, %esi
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	leaq	0xb0(%rsp), %r9
               	vzeroupper
               	callq	<addr>
               	vmovups	0x30(%rsp), %ymm14
               	vmovq	%rbx, %xmm15
               	vpsrlw	%xmm15, %ymm14, %ymm0
               	vmovups	%ymm0, 0xd0(%rsp)
               	leaq	0xd0(%rsp), %rdi
               	leaq	0xb0(%rsp), %rsi
               	movl	$0x20, %edx
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
               	movq	%rbx, %r8
               	leaq	0x50(%rsp), %rdi
               	movl	$0x20, %esi
               	movl	$0x2, %edx
               	movl	$0x2, %ecx
               	leaq	0xb0(%rsp), %r9
               	vzeroupper
               	callq	<addr>
               	vmovups	0x30(%rsp), %ymm14
               	vmovq	%rbx, %xmm15
               	vpsraw	%xmm15, %ymm14, %ymm0
               	vmovups	%ymm0, 0xd0(%rsp)
               	leaq	0xd0(%rsp), %rdi
               	leaq	0xb0(%rsp), %rsi
               	movl	$0x20, %edx
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
               	movq	%rbx, %r8
               	leaq	0x50(%rsp), %rdi
               	movl	$0x20, %esi
               	movl	$0x4, %edx
               	movl	$0x2, %ecx
               	leaq	0xb0(%rsp), %r9
               	vzeroupper
               	callq	<addr>
               	vmovups	0x30(%rsp), %ymm14
               	vmovq	%rbx, %xmm15
               	vpsrad	%xmm15, %ymm14, %ymm0
               	vmovups	%ymm0, 0xd0(%rsp)
               	leaq	0xd0(%rsp), %rdi
               	leaq	0xb0(%rsp), %rsi
               	movl	$0x20, %edx
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
               	cmpl	$0xb, %r12d
               	jb	<addr>
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	testq	%r13, %r13
               	cmoveq	%rcx, %rax
               	orq	%rax, %r14
               	leaq	0x50(%rsp), %rdi
               	leaq	0x70(%rsp), %rsi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %r14
               	leaq	0x50(%rsp), %rdi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %r14
               	leaq	0x50(%rsp), %rdi
               	leaq	0x70(%rsp), %rsi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %r14
               	leaq	0x50(%rsp), %rdi
               	leaq	0x70(%rsp), %rsi
               	leaq	0x90(%rsp), %rdx
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %r14
               	leaq	0x50(%rsp), %rdi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %r14
               	leaq	0x50(%rsp), %rdi
               	leaq	0x70(%rsp), %rsi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %r14
               	leaq	0x50(%rsp), %rdi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %r14
               	incq	%r15
               	cmpl	$0xc8, %r15d
               	jl	<addr>
               	movq	%r14, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	addq	$0xd0, %rsp
               	retq

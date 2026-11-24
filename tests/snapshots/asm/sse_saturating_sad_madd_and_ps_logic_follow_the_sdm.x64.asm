
sse_saturating_sad_madd_and_ps_logic_follow_the_sdm.x64:	file format elf64-x86-64

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

<check_sad_madd>:
               	subq	$0x38, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movups	(%rdi), %xmm0
               	movups	(%rsi), %xmm1
               	vpsadbw	%xmm1, %xmm0, %xmm2
               	vpmaddubsw	%xmm1, %xmm0, %xmm0
               	movups	%xmm2, 0x20(%rsp)
               	movups	%xmm0, 0x30(%rsp)
               	xorl	%r12d, %r12d
               	xorl	%eax, %eax
               	movq	%r12, %r8
               	shlq	$0x3, %r8
               	movq	%rax, %rdx
               	jmp	<addr>
               	addq	%rcx, %rdx
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	(%r8,%rax), %rcx
               	movzbq	(%rdi,%rcx), %r9
               	movzbq	(%rsi,%rcx), %rcx
               	cmpl	%ecx, %r9d
               	jle	<addr>
               	negq	%rcx
               	addq	%r9, %rcx
               	nop
               	jmp	<addr>
               	leaq	(%r8,%rax), %rcx
               	movzbq	(%rsi,%rcx), %r9
               	movzbq	(%rdi,%rcx), %rcx
               	negq	%rcx
               	addq	%r9, %rcx
               	jmp	<addr>
               	leaq	0x18(%rsp), %rcx
               	leaq	0x20(%rsp), %rax
               	movq	%r12, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movq	(%rax), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	incq	%r12
               	cmpl	$0x2, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	%rcx
               	movzbq	(%rdi,%rcx), %rdx
               	movzbq	(%rsi,%rcx), %r8
               	movsbq	%r8b, %r8
               	imulq	%r8, %rdx
               	leaq	0x1(%rcx), %r8
               	movzbq	(%rdi,%r8), %r9
               	movzbq	(%rsi,%r8), %rbx
               	movsbq	%bl, %rbx
               	imulq	%rbx, %r9
               	addq	%rdx, %r9
               	movq	$-0x8000, %rdx          # imm = 0x8000
               	movl	$0x7fff, %ebx           # imm = 0x7FFF
               	cmpl	%edx, %r9d
               	jge	<addr>
               	movzbq	0x30(%rsp,%rcx), %rcx
               	movzbq	0x30(%rsp,%r8), %r8
               	shlq	$0x8, %r8
               	orq	%r8, %rcx
               	movswq	%cx, %rcx
               	cmpl	%edx, %ecx
               	je	<addr>
               	jmp	<addr>
               	cmpl	%ebx, %r9d
               	movq	%r9, %rdx
               	cmovgq	%rbx, %rdx
               	jmp	<addr>
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq

<check_ps_logic>:
               	subq	$0x58, %rsp
               	movups	(%rdi), %xmm1
               	movups	(%rsi), %xmm0
               	vandps	%xmm0, %xmm1, %xmm2
               	movups	%xmm2, (%rsp)
               	vandnps	%xmm0, %xmm1, %xmm2
               	movups	%xmm2, 0x10(%rsp)
               	vorps	%xmm0, %xmm1, %xmm2
               	movups	%xmm2, 0x20(%rsp)
               	vxorps	%xmm0, %xmm1, %xmm0
               	movups	%xmm0, 0x30(%rsp)
               	xorl	%edx, %edx
               	leaq	(%rsp), %rax
               	movq	%rdx, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	movups	(%rax), %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%rsi,%rax), %r9
               	andq	%r9, %rcx
               	movzbq	0x40(%rsp,%rax), %r9
               	nop
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
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%rsi,%rax), %r9
               	xorq	%r9, %rcx
               	movzbq	0x40(%rsp,%rax), %r9
               	cmpl	%ecx, %r9d
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x4, %edx
               	jl	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	%xmm1, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	$0x58, %rsp
               	retq
               	movl	$0x1, %eax
               	addq	$0x58, %rsp
               	retq

<main>:
               	subq	$0xc8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	xorl	%r10d, %r10d
               	movq	%r10, 0xb8(%rsp)
               	xorl	%eax, %eax
               	nop
               	jmp	<addr>
               	movb	%cl, 0xc0(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
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
               	nop
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, 0xd0(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
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
               	nopl	(%rax)
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
               	movups	0xc0(%rsp), %xmm0
               	movups	0xd0(%rsp), %xmm1
               	vpaddsb	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, 0x30(%rsp)
               	vpaddsw	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, 0x40(%rsp)
               	vpaddusb	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, 0x50(%rsp)
               	vpaddusw	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, 0x60(%rsp)
               	vpsubsb	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, 0x70(%rsp)
               	vpsubsw	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, 0x80(%rsp)
               	vpsubusb	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, 0x90(%rsp)
               	vpsubusw	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0xa0(%rsp)
               	xorl	%r9d, %r9d
               	movl	$0x2, %esi
               	movl	$0x1, %eax
               	testb	$0x1, %r9b
               	cmoveq	%rax, %rsi
               	movq	%r9, %r8
               	andq	$0x2, %r8
               	testl	%r8d, %r8d
               	sete	%r13b
               	movzbq	%r13b, %r13
               	testl	%r8d, %r8d
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	shlxq	%rcx, %rax, %rax
               	movq	%rax, %rdi
               	negq	%rdi
               	nopl	(%rax)
               	testl	%r8d, %r8d
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	shlxq	%rcx, %rax, %rax
               	leaq	-0x1(%rax), %r14
               	leaq	0xe0(%rsp), %rax
               	leaq	0x30(%rsp), %rcx
               	movq	%r9, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	cmpl	$0x1, %esi
               	jne	<addr>
               	nopl	(%rax,%rax)
               	testl	%r8d, %r8d
               	jne	<addr>
               	movzbq	0xc0(%rsp,%rcx), %rax
               	movsbq	%al, %rax
               	cmpl	$0x1, %esi
               	jne	<addr>
               	nop
               	testl	%r8d, %r8d
               	jne	<addr>
               	movzbq	0xd0(%rsp,%rcx), %rdx
               	movsbq	%dl, %rdx
               	movq	%rax, %r15
               	subq	%rdx, %r15
               	addq	%rdx, %rax
               	cmpl	$0x4, %r9d
               	cmovgeq	%r15, %rax
               	cmpq	%rdi, %rax
               	jge	<addr>
               	movq	%rdi, %rdx
               	cmpl	$0x1, %esi
               	jne	<addr>
               	nopl	(%rax,%rax)
               	testl	%r8d, %r8d
               	jne	<addr>
               	movzbq	0xe0(%rsp,%rcx), %rax
               	movsbq	%al, %rax
               	cmpq	%rdx, %rax
               	je	<addr>
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	movzbq	0xe0(%rsp,%rcx), %rax
               	jmp	<addr>
               	movq	%rcx, %r15
               	shlq	%r15
               	movslq	%r15d, %r15
               	movzbq	0xe0(%rsp,%r15), %rbp
               	incq	%r15
               	movslq	%r15d, %r15
               	movzbq	0xe0(%rsp,%r15), %rax
               	shlq	$0x8, %rax
               	orq	%rbp, %rax
               	movswq	%ax, %r15
               	testq	%r13, %r13
               	cmovneq	%r15, %rax
               	jmp	<addr>
               	cmpq	%r14, %rax
               	movq	%rax, %rdx
               	cmovgq	%r14, %rdx
               	jmp	<addr>
               	movzbq	0xd0(%rsp,%rcx), %rdx
               	nopl	(%rax)
               	jmp	<addr>
               	movq	%rcx, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	movzbq	0xd0(%rsp,%rdx), %r15
               	incq	%rdx
               	movslq	%edx, %rdx
               	movzbq	0xd0(%rsp,%rdx), %rdx
               	shlq	$0x8, %rdx
               	orq	%r15, %rdx
               	movswq	%dx, %r15
               	testq	%r13, %r13
               	cmovneq	%r15, %rdx
               	jmp	<addr>
               	movzbq	0xc0(%rsp,%rcx), %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	shlq	%rax
               	movslq	%eax, %rax
               	movzbq	0xc0(%rsp,%rax), %rdx
               	incq	%rax
               	movslq	%eax, %rax
               	movzbq	0xc0(%rsp,%rax), %rax
               	shlq	$0x8, %rax
               	orq	%rdx, %rax
               	movswq	%ax, %rdx
               	testq	%r13, %r13
               	cmovneq	%rdx, %rax
               	nop
               	jmp	<addr>
               	incq	%rcx
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %ecx
               	jl	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	shlxq	%rcx, %rax, %rax
               	leaq	-0x1(%rax), %r14
               	jmp	<addr>
               	xorl	%edi, %edi
               	jmp	<addr>
               	incq	%r9
               	nop
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	leaq	0xc0(%rsp), %rdi
               	leaq	0xd0(%rsp), %rsi
               	callq	<addr>
               	nop
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0xc0(%rsp), %rdi
               	leaq	0xd0(%rsp), %rsi
               	callq	<addr>
               	nopl	(%rax)
               	testl	%eax, %eax
               	jne	<addr>
               	addq	$0x1, 0xb8(%rsp)
               	nopw	%cs:(%rax,%rax)
               	nopl	(%rax,%rax)
               	movq	0xb8(%rsp), %rax
               	cmpl	$0xc8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x8c, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x8b, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x8a, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0xc8, %rsp
               	retq

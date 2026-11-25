
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
               	subq	$0x40, %rsp
               	pushq	%rbx
               	movups	(%rdi), %xmm0
               	movups	(%rsi), %xmm1
               	vpsadbw	%xmm1, %xmm0, %xmm2
               	vpmaddubsw	%xmm1, %xmm0, %xmm0
               	movups	%xmm2, 0x20(%rsp)
               	movups	%xmm0, 0x30(%rsp)
               	xorl	%ebx, %ebx
               	xorl	%eax, %eax
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rax, %r8
               	leaq	(%r9,%rax), %rdx
               	movzbq	(%rdi,%rdx), %rcx
               	movzbq	(%rsi,%rdx), %rdx
               	movq	%rcx, %r10
               	subq	%rdx, %r10
               	movq	%rdx, %r11
               	subq	%rcx, %r11
               	cmpl	%edx, %ecx
               	cmovleq	%r11, %r10
               	addq	%r10, %r8
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x18(%rsp), %rcx
               	leaq	0x20(%rsp), %rax
               	movq	%rbx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movq	(%rax), %rax
               	cmpq	%r8, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x2, %ebx
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
               	movzbq	(%rsi,%r8), %r10
               	movsbq	%r10b, %r10
               	imulq	%r10, %r9
               	addq	%rdx, %r9
               	movq	$-0x8000, %rdx          # imm = 0x8000
               	movl	$0x7fff, %r10d          # imm = 0x7FFF
               	cmpl	%edx, %r9d
               	jge	<addr>
               	movzbq	0x30(%rsp,%rcx), %r10
               	movzbq	0x30(%rsp,%r8), %rcx
               	shlq	$0x8, %rcx
               	orq	%rcx, %r10
               	movswq	%r10w, %rcx
               	cmpl	%edx, %ecx
               	je	<addr>
               	jmp	<addr>
               	cmpl	%r10d, %r9d
               	movq	%r9, %rdx
               	cmovgq	%r10, %rdx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x40, %rsp
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
               	movups	%xmm1, 0x40(%rsp)
               	movq	%rdi, %rsi
               	leaq	0x40(%rsp), %rdi
               	movl	$0x10, %edx
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
               	subq	$0xc0, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r15d, %r15d
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movb	%al, 0xb0(%rsp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
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
               	movb	%al, 0xc0(%rsp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
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
               	movups	0xb0(%rsp), %xmm0
               	movups	0xc0(%rsp), %xmm1
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
               	sete	%bl
               	movzbq	%bl, %rbx
               	testl	%r8d, %r8d
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	shlxq	%rcx, %rax, %rax
               	movq	%rax, %rdi
               	negq	%rdi
               	testl	%r8d, %r8d
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	shlxq	%rcx, %rax, %rax
               	leaq	-0x1(%rax), %r13
               	leaq	0xd0(%rsp), %rax
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
               	nopw	(%rax,%rax)
               	cmpl	$0x1, %esi
               	jne	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movzbq	0xb0(%rsp,%rcx), %rax
               	movsbq	%al, %rax
               	nop
               	cmpl	$0x1, %esi
               	jne	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movzbq	0xc0(%rsp,%rcx), %rdx
               	movsbq	%dl, %rdx
               	movq	%rax, %r12
               	subq	%rdx, %r12
               	addq	%rdx, %rax
               	cmpl	$0x4, %r9d
               	cmovgeq	%r12, %rax
               	cmpq	%rdi, %rax
               	jge	<addr>
               	movq	%rdi, %rdx
               	nopl	(%rax)
               	cmpl	$0x1, %esi
               	jne	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movzbq	0xd0(%rsp,%rcx), %rax
               	movsbq	%al, %rax
               	nopw	(%rax,%rax)
               	cmpq	%rdx, %rax
               	je	<addr>
               	jmp	<addr>
               	movzbq	0xd0(%rsp,%rcx), %rax
               	jmp	<addr>
               	movq	%rcx, %r12
               	shlq	%r12
               	movslq	%r12d, %r14
               	movzbq	0xd0(%rsp,%r14), %r12
               	incq	%r14
               	movslq	%r14d, %r14
               	movzbq	0xd0(%rsp,%r14), %rax
               	shlq	$0x8, %rax
               	orq	%rax, %r12
               	movswq	%r12w, %rax
               	testq	%rbx, %rbx
               	cmoveq	%r12, %rax
               	jmp	<addr>
               	cmpq	%r13, %rax
               	movq	%rax, %rdx
               	cmovgq	%r13, %rdx
               	jmp	<addr>
               	movzbq	0xc0(%rsp,%rcx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	shlq	%rdx
               	movslq	%edx, %r12
               	movzbq	0xc0(%rsp,%r12), %rdx
               	incq	%r12
               	movslq	%r12d, %r12
               	movzbq	0xc0(%rsp,%r12), %r12
               	shlq	$0x8, %r12
               	orq	%r12, %rdx
               	movswq	%dx, %r12
               	testq	%rbx, %rbx
               	cmovneq	%r12, %rdx
               	nop
               	jmp	<addr>
               	movzbq	0xb0(%rsp,%rcx), %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	shlq	%rax
               	movslq	%eax, %rdx
               	movzbq	0xb0(%rsp,%rdx), %rax
               	incq	%rdx
               	movslq	%edx, %rdx
               	movzbq	0xb0(%rsp,%rdx), %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rax
               	movswq	%ax, %rdx
               	testq	%rbx, %rbx
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	incq	%rcx
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %ecx
               	jl	<addr>
               	nop
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	shlxq	%rcx, %rax, %rax
               	leaq	-0x1(%rax), %r13
               	jmp	<addr>
               	xorl	%edi, %edi
               	nop
               	jmp	<addr>
               	incq	%r9
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	leaq	0xb0(%rsp), %rdi
               	leaq	0xc0(%rsp), %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0xb0(%rsp), %rdi
               	leaq	0xc0(%rsp), %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	incq	%r15
               	cmpl	$0xc8, %r15d
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0xc0, %rsp
               	retq
               	movl	$0x8c, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0xc0, %rsp
               	retq
               	movl	$0x8b, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0xc0, %rsp
               	retq
               	movl	$0x8a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0xc0, %rsp
               	retq

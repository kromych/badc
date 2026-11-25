
bmi_lzcnt_and_adx_follow_the_sdm.x64:	file format elf64-x86-64

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

<_subborrow_u64>:
               	cmpq	$0x1, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	leaq	-0x1(%rsi), %rdx
               	negq	%rax
               	andq	$0xff, %rdi
               	testl	%edi, %edi
               	setne	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rsi, %rdx
               	subq	%rdi, %rax
               	movq	%rdx, (%rcx)
               	shrq	$0x3f, %rax
               	retq

<main>:
               	subq	$0x40, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r8d, %r8d
               	movl	<rip>, %r10d # <addr>
               	movl	<rip>, %r11d # <addr>
               	movl	<rip>, %edi # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	<rip>, %rbx # <addr>
               	testq	%r11, %r11
               	je	<addr>
               	bsrl	%r11d, %ecx
               	xorl	$0x1f, %ecx
               	cmpl	$0x20, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	bsrl	%ecx, %ecx
               	xorl	$0x1f, %ecx
               	cmpl	$0x1f, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	bsrl	%ecx, %ecx
               	xorl	$0x1f, %ecx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	movq	%r10, 0x20(%rsp)
               	movl	$0x7f, %r10d
               	bsrq	%r13, %rcx
               	cmovel	%r10d, %ecx
               	xorl	$0x3f, %ecx
               	cmpl	$0x40, %ecx
               	movq	0x20(%rsp), %r10
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	%r10, 0x20(%rsp)
               	movl	$0x7f, %r10d
               	bsrq	%rax, %rcx
               	cmovel	%r10d, %ecx
               	xorl	$0x3f, %ecx
               	cmpl	$0x7, %ecx
               	movq	0x20(%rsp), %r10
               	jne	<addr>
               	testq	%r10, %r10
               	je	<addr>
               	bsfl	%r10d, %ecx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x1, %r8d
               	movq	%r10, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rdi, %rcx
               	cmpl	$0xff0f0f0f, %ecx       # imm = 0xFF0F0F0F
               	jne	<addr>
               	movq	%rax, %rcx
               	xorq	$-0x1, %rcx
               	movq	%rcx, %rdx
               	andq	%rbx, %rdx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movq	%r10, %rcx
               	negq	%rcx
               	andq	%r10, %rcx
               	cmpl	$0x10, %ecx
               	jne	<addr>
               	leaq	-0x1(%r10), %rcx
               	movq	%r10, %rdx
               	xorq	%rcx, %rdx
               	cmpl	$0x1f, %edx
               	jne	<addr>
               	andq	%r10, %rcx
               	cmpl	$0xf0f0e0, %ecx         # imm = 0xF0F0E0
               	jne	<addr>
               	movq	%r11, %rcx
               	negq	%rcx
               	andq	%r11, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	-0x1(%r11), %rcx
               	xorq	%r11, %rcx
               	cmpl	$-0x1, %ecx
               	jne	<addr>
               	leaq	-0x1(%rax), %rcx
               	andq	%rax, %rcx
               	movq	%r10, 0x20(%rsp)
               	movabsq	$0x123456789abcdee, %r10 # imm = 0x123456789ABCDEE
               	cmpq	%r10, %rcx
               	movq	0x20(%rsp), %r10
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x1(%rcx), %rdx
               	xorq	%rdx, %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	orq	$0x2, %r8
               	movq	%r10, %rcx
               	shrq	$0x4, %rcx
               	andq	$0xff, %rcx
               	xorq	$0xf, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%r10, %rdx
               	shrq	$0x14, %rdx
               	cmpl	$0xf, %edx
               	jne	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3c, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	$0xabcd, %ecx           # imm = 0xABCD
               	jne	<addr>
               	movq	%rdi, %rcx
               	andq	$0x7fffffff, %rcx       # imm = 0x7FFFFFFF
               	cmpl	$0x7fffffff, %ecx       # imm = 0x7FFFFFFF
               	jne	<addr>
               	movq	%r10, %rcx
               	andq	$0xff, %rcx
               	cmpl	$0xf0, %ecx
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rbx, %rcx
               	movq	%r10, 0x20(%rsp)
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r10, %rcx
               	movq	0x20(%rsp), %r10
               	jne	<addr>
               	movl	$0xf0f0f0, %ecx         # imm = 0xF0F0F0
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	jmp	<addr>
               	shlq	%rsi
               	leaq	-0x1(%rcx), %r9
               	andq	%r9, %rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	testb	$0x2d, %sil
               	je	<addr>
               	movq	%rcx, %r9
               	negq	%r9
               	andq	%rcx, %r9
               	orq	%r9, %rdx
               	jmp	<addr>
               	cmpl	$0x20d0, %edx           # imm = 0x20D0
               	jne	<addr>
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	movq	%r11, %rcx
               	jmp	<addr>
               	shlq	%rsi
               	leaq	-0x1(%rcx), %r9
               	andq	%r9, %rcx
               	nopl	(%rax,%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	%esi, %r9d
               	andq	%rdi, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	%rcx, %r9
               	negq	%r9
               	andq	%rcx, %r9
               	orq	%r9, %rdx
               	nopl	(%rax)
               	jmp	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0xff00ff, %ecx         # imm = 0xFF00FF
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	movq	%r10, %r9
               	andq	%rcx, %r9
               	movq	%rcx, %r12
               	negq	%r12
               	movl	%r12d, %r12d
               	andq	%r12, %r9
               	movq	%rdx, %r12
               	orq	%rsi, %r12
               	testq	%r9, %r9
               	cmovneq	%r12, %rdx
               	shlq	%rsi
               	leaq	-0x1(%rcx), %r9
               	andq	%r9, %rcx
               	nop
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	$0xf0f0, %edx           # imm = 0xF0F0
               	jne	<addr>
               	movl	$0x80000001, %ecx       # imm = 0x80000001
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	movq	%rdi, %r9
               	andq	%rcx, %r9
               	movq	%rcx, %r12
               	negq	%r12
               	movl	%r12d, %r12d
               	andq	%r12, %r9
               	movq	%rdx, %r12
               	orq	%rsi, %r12
               	testq	%r9, %r9
               	cmovneq	%r12, %rdx
               	shlq	%rsi
               	leaq	-0x1(%rcx), %r9
               	andq	%r9, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	$0x3, %edx
               	jne	<addr>
               	movabsq	$-0x100000000000000, %rcx # imm = 0xFF00000000000000
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	jmp	<addr>
               	shlq	%rsi
               	leaq	-0x1(%rcx), %r9
               	andq	%r9, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %r9
               	andq	%rsi, %r9
               	nopl	(%rax)
               	testq	%r9, %r9
               	je	<addr>
               	movq	%rcx, %r9
               	negq	%r9
               	andq	%rcx, %r9
               	orq	%r9, %rdx
               	jmp	<addr>
               	movq	%r10, 0x20(%rsp)
               	movabsq	$-0x1100000000000000, %r10 # imm = 0xEF00000000000000
               	movq	%rdx, %rcx
               	cmpq	%r10, %rdx
               	movq	0x20(%rsp), %r10
               	jne	<addr>
               	movabsq	$-0xfffffffffffff10, %rcx # imm = 0xF0000000000000F0
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	movq	%rax, %r9
               	andq	%rcx, %r9
               	movq	%rcx, %r12
               	negq	%r12
               	andq	%r12, %r9
               	movq	%rdx, %r12
               	orq	%rsi, %r12
               	testq	%r9, %r9
               	cmovneq	%r12, %rdx
               	shlq	%rsi
               	leaq	-0x1(%rcx), %r9
               	andq	%r9, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	$0xe, %rdx
               	je	<addr>
               	orq	$0x10, %r8
               	movq	%rbx, %rcx
               	imulq	%rax, %rcx
               	movq	%rax, %r9
               	movq	%rax, -0x18(%rsp)
               	movq	%rbx, %rax
               	mulq	%r9
               	movq	-0x18(%rsp), %rax
               	movq	%r10, 0x20(%rsp)
               	movabsq	$-0x123456789abcdef, %r10 # imm = 0xFEDCBA9876543211
               	cmpq	%r10, %rcx
               	movq	0x20(%rsp), %r10
               	jne	<addr>
               	movq	%r10, 0x20(%rsp)
               	movabsq	$0x123456789abcdee, %r10 # imm = 0x123456789ABCDEE
               	movq	%rdx, %rcx
               	cmpq	%r10, %rdx
               	movq	0x20(%rsp), %r10
               	jne	<addr>
               	movq	%r13, %rcx
               	imulq	%rax, %rcx
               	movq	%rax, %r9
               	movq	%rax, -0x18(%rsp)
               	movq	%r13, %rax
               	mulq	%r9
               	movq	-0x18(%rsp), %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	orq	$0x20, %r8
               	leaq	0x1(%rdi), %rcx
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	0x1(%r10), %rcx
               	incq	%rcx
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	0x2(%r10), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	leaq	(%rdi,%rdi), %rcx
               	incq	%rcx
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	cmpl	%edi, %ecx
               	je	<addr>
               	orq	$0x40, %r8
               	leaq	-0x1(%r11), %rcx
               	movq	%rcx, %rdx
               	shrq	$0x3f, %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	cmpl	%edi, %ecx
               	jne	<addr>
               	leaq	(%rbx,%r13), %rcx
               	cmpq	%rbx, %rcx
               	setb	%sil
               	movzbq	%sil, %rsi
               	leaq	0x1(%rcx), %rdx
               	cmpq	%rcx, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%rsi, %rcx
               	movq	%rdx, 0x48(%rsp)
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rax, 0x38(%rsp)
               	movq	%r8, 0x30(%rsp)
               	movq	%r13, %rsi
               	xorl	%edi, %edi
               	movl	$0x1, %edx
               	leaq	0x48(%rsp), %rcx
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	0x38(%rsp), %rax
               	movq	0x30(%rsp), %r8
               	andq	$0xff, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	0x48(%rsp), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	movq	%rax, 0x38(%rsp)
               	movq	%r8, 0x30(%rsp)
               	movq	%rax, %rsi
               	movl	$0x1, %edi
               	movl	$0x1, %edx
               	leaq	0x48(%rsp), %rcx
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	0x38(%rsp), %rax
               	movq	0x30(%rsp), %r8
               	testb	$-0x1, %cl
               	jne	<addr>
               	movq	0x48(%rsp), %rcx
               	leaq	-0x2(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	leaq	(%rax,%rax), %rcx
               	cmpq	%rax, %rcx
               	movq	%rcx, 0x48(%rsp)
               	jb	<addr>
               	shlq	%rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	orq	$0x80, %r8
               	movq	%r8, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x40, %rsp
               	retq
               	orq	$0x8, %r8
               	jmp	<addr>
               	orq	$0x4, %r8
               	jmp	<addr>

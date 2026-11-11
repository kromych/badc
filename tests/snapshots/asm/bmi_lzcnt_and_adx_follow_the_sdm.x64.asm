
bmi_lzcnt_and_adx_follow_the_sdm.x64:	file format elf64-x86-64

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

<_subborrow_u64>:
               	cmpq	$0x1, %rsi
               	setb	%dl
               	movzbq	%dl, %rdx
               	leaq	-0x1(%rsi), %rax
               	movq	%rdx, %rsi
               	negq	%rsi
               	andq	$0xff, %rdi
               	testl	%edi, %edi
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rdx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rdx, %rax
               	subq	%rdi, %rsi
               	movq	%rax, (%rcx)
               	movq	%rsi, %rax
               	shrq	$0x3f, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r12d, %r12d
               	movl	<rip>, %r8d # <addr>
               	movl	<rip>, %r9d # <addr>
               	movl	<rip>, %edi # <addr>
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %r15 # <addr>
               	movq	<rip>, %r14 # <addr>
               	testq	%r9, %r9
               	je	<addr>
               	bsrl	%r9d, %eax
               	xorl	$0x1f, %eax
               	cmpl	$0x20, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	bsrl	%eax, %eax
               	xorl	$0x1f, %eax
               	cmpl	$0x1f, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	bsrl	%eax, %eax
               	xorl	$0x1f, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	testq	%r15, %r15
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%r15, %rax
               	cmovel	%r11d, %eax
               	xorl	$0x3f, %eax
               	cmpl	$0x40, %eax
               	jne	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%rbx, %rax
               	cmovel	%r11d, %eax
               	xorl	$0x3f, %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	testq	%r8, %r8
               	je	<addr>
               	bsfl	%r8d, %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x1, %r12d
               	movq	%r8, %rax
               	xorq	$-0x1, %rax
               	andq	%rdi, %rax
               	cmpl	$0xff0f0f0f, %eax       # imm = 0xFF0F0F0F
               	jne	<addr>
               	movq	%rbx, %rax
               	xorq	$-0x1, %rax
               	movq	%rax, %rcx
               	andq	%r14, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	%r8, %rax
               	negq	%rax
               	andq	%r8, %rax
               	cmpl	$0x10, %eax
               	jne	<addr>
               	leaq	-0x1(%r8), %rax
               	movq	%r8, %rcx
               	xorq	%rax, %rcx
               	cmpl	$0x1f, %ecx
               	jne	<addr>
               	andq	%r8, %rax
               	cmpl	$0xf0f0e0, %eax         # imm = 0xF0F0E0
               	jne	<addr>
               	movq	%r9, %rax
               	negq	%rax
               	andq	%r9, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x1(%r9), %rax
               	xorq	%r9, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	leaq	-0x1(%rbx), %rax
               	andq	%rbx, %rax
               	movabsq	$0x123456789abcdee, %r11 # imm = 0x123456789ABCDEE
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	-0x1(%rax), %rcx
               	xorq	%rcx, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	orq	$0x2, %r12
               	movq	%r8, %rax
               	shrq	$0x4, %rax
               	andq	$0xff, %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movq	%r8, %rcx
               	shrq	$0x14, %rcx
               	cmpl	$0xf, %ecx
               	jne	<addr>
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movq	%rbx, %rax
               	shrq	$0x3c, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rbx, %rax
               	shrq	$0x8, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xabcd, %eax           # imm = 0xABCD
               	jne	<addr>
               	movq	%rdi, %rax
               	andq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	cmpl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	jne	<addr>
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	cmpl	$0xf0, %eax
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r14, %rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0xf0f0f0, %ecx         # imm = 0xF0F0F0
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	testb	$0x2d, %sil
               	je	<addr>
               	movq	%rcx, %rax
               	negq	%rax
               	andq	%rcx, %rax
               	orq	%rax, %rdx
               	shlq	%rsi
               	leaq	-0x1(%rcx), %rax
               	andq	%rax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	$0x20d0, %edx           # imm = 0x20D0
               	jne	<addr>
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	movq	%r9, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	%esi, %eax
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	negq	%rax
               	andq	%rcx, %rax
               	orq	%rax, %rdx
               	shlq	%rsi
               	leaq	-0x1(%rcx), %rax
               	andq	%rax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0xff00ff, %ecx         # imm = 0xFF00FF
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	movq	%r8, %rax
               	andq	%rcx, %rax
               	movq	%rcx, %r13
               	negq	%r13
               	movl	%r13d, %r13d
               	andq	%rax, %r13
               	movq	%rdx, %rax
               	orq	%rsi, %rax
               	testq	%r13, %r13
               	cmovneq	%rax, %rdx
               	shlq	%rsi
               	leaq	-0x1(%rcx), %rax
               	andq	%rax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	$0xf0f0, %edx           # imm = 0xF0F0
               	jne	<addr>
               	movl	$0x80000001, %ecx       # imm = 0x80000001
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	movq	%rdi, %rax
               	andq	%rcx, %rax
               	movq	%rcx, %r13
               	negq	%r13
               	movl	%r13d, %r13d
               	andq	%rax, %r13
               	movq	%rdx, %rax
               	orq	%rsi, %rax
               	testq	%r13, %r13
               	cmovneq	%rax, %rdx
               	shlq	%rsi
               	leaq	-0x1(%rcx), %rax
               	andq	%rax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	$0x3, %edx
               	jne	<addr>
               	movabsq	$-0x100000000000000, %rcx # imm = 0xFF00000000000000
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	movq	%rbx, %rax
               	andq	%rsi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	negq	%rax
               	andq	%rcx, %rax
               	orq	%rax, %rdx
               	shlq	%rsi
               	leaq	-0x1(%rcx), %rax
               	andq	%rax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$-0x1100000000000000, %r11 # imm = 0xEF00000000000000
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0xfffffffffffff10, %rcx # imm = 0xF0000000000000F0
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	movq	%rbx, %rax
               	andq	%rcx, %rax
               	movq	%rcx, %r13
               	negq	%r13
               	andq	%rax, %r13
               	movq	%rdx, %rax
               	orq	%rsi, %rax
               	testq	%r13, %r13
               	cmovneq	%rax, %rdx
               	shlq	%rsi
               	leaq	-0x1(%rcx), %rax
               	andq	%rax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	$0xe, %rdx
               	je	<addr>
               	orq	$0x10, %r12
               	xorl	%ecx, %ecx
               	movq	%r14, %rsi
               	imulq	%rbx, %rsi
               	movq	%r14, %rax
               	mulq	%rbx
               	movq	%r14, %rax
               	imulq	%rcx, %rax
               	imulq	%rbx, %rcx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	movabsq	$-0x123456789abcdef, %r11 # imm = 0xFEDCBA9876543211
               	movq	%rsi, %rcx
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$0x123456789abcdee, %r11 # imm = 0x123456789ABCDEE
               	cmpq	%r11, %rax
               	jne	<addr>
               	xorl	%ecx, %ecx
               	movq	%r15, %rsi
               	imulq	%rbx, %rsi
               	movq	%r15, %rax
               	mulq	%rbx
               	movq	%r15, %rax
               	imulq	%rcx, %rax
               	imulq	%rbx, %rcx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	orq	$0x20, %r12
               	leaq	0x1(%rdi), %rax
               	movl	%eax, -0x8(%rbp)
               	shrq	$0x20, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpl	$0x0, -0x8(%rbp)
               	jne	<addr>
               	movl	%edi, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	%edi, %eax
               	jne	<addr>
               	leaq	0x1(%r8), %rax
               	incq	%rax
               	movl	%eax, -0x8(%rbp)
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	leaq	0x2(%r8), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	(%rdi,%rdi), %rax
               	incq	%rax
               	movl	%eax, -0x8(%rbp)
               	shrq	$0x20, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	cmpl	%edi, %eax
               	je	<addr>
               	orq	$0x40, %r12
               	leaq	-0x1(%r9), %rax
               	movl	%eax, -0x8(%rbp)
               	shrq	$0x3f, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	cmpl	%edi, %eax
               	jne	<addr>
               	movl	$0x0, -0x8(%rbp)
               	cmpl	$0x0, -0x8(%rbp)
               	jne	<addr>
               	leaq	(%r14,%r15), %rax
               	cmpq	%r14, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	leaq	0x1(%rax), %rcx
               	cmpq	%rax, %rcx
               	setb	%al
               	movzbq	%al, %rax
               	addq	%rdx, %rax
               	movq	%rcx, -0x8(%rbp)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpq	$0x0, -0x8(%rbp)
               	jne	<addr>
               	xorl	%edi, %edi
               	movl	$0x1, %edx
               	leaq	-0x8(%rbp), %rcx
               	movq	%r15, %rsi
               	callq	<addr>
               	andq	$0xff, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	%r14, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	-0x8(%rbp), %rcx
               	movq	%rbx, %rsi
               	movq	%rdi, %rdx
               	callq	<addr>
               	testb	$-0x1, %al
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	leaq	-0x2(%rbx), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	(%rbx,%rbx), %rax
               	cmpq	%rbx, %rax
               	movq	%rax, -0x8(%rbp)
               	jb	<addr>
               	movq	-0x8(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	orq	$0x80, %r12
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	orq	$0x8, %r12
               	jmp	<addr>
               	orq	$0x4, %r12
               	jmp	<addr>

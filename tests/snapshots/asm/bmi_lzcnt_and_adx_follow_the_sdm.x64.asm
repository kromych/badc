
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
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r8d, %r8d
               	movl	<rip>, %ebx # <addr>
               	movl	<rip>, %r12d # <addr>
               	movl	<rip>, %edi # <addr>
               	movq	<rip>, %r9 # <addr>
               	movq	<rip>, %r14 # <addr>
               	movq	<rip>, %r13 # <addr>
               	testq	%r12, %r12
               	je	<addr>
               	bsrl	%r12d, %eax
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
               	testq	%r14, %r14
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%r14, %rax
               	cmovel	%r11d, %eax
               	xorl	$0x3f, %eax
               	cmpl	$0x40, %eax
               	jne	<addr>
               	testq	%r9, %r9
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%r9, %rax
               	cmovel	%r11d, %eax
               	xorl	$0x3f, %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	bsfl	%ebx, %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x1, %r8d
               	movq	%rbx, %rax
               	xorq	$-0x1, %rax
               	andq	%rdi, %rax
               	cmpl	$0xff0f0f0f, %eax       # imm = 0xFF0F0F0F
               	jne	<addr>
               	movq	%r9, %rax
               	xorq	$-0x1, %rax
               	movq	%rax, %rcx
               	andq	%r13, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	%rbx, %rax
               	negq	%rax
               	andq	%rbx, %rax
               	cmpl	$0x10, %eax
               	jne	<addr>
               	leaq	-0x1(%rbx), %rax
               	movq	%rbx, %rcx
               	xorq	%rax, %rcx
               	cmpl	$0x1f, %ecx
               	jne	<addr>
               	andq	%rbx, %rax
               	cmpl	$0xf0f0e0, %eax         # imm = 0xF0F0E0
               	jne	<addr>
               	movq	%r12, %rax
               	negq	%rax
               	andq	%r12, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x1(%r12), %rax
               	xorq	%r12, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	leaq	-0x1(%r9), %rax
               	andq	%r9, %rax
               	movabsq	$0x123456789abcdee, %r11 # imm = 0x123456789ABCDEE
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	-0x1(%rax), %rcx
               	xorq	%rcx, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	orq	$0x2, %r8
               	movq	%rbx, %rax
               	shrq	$0x4, %rax
               	andq	$0xff, %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movq	%rbx, %rcx
               	shrq	$0x14, %rcx
               	cmpl	$0xf, %ecx
               	jne	<addr>
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movq	%r9, %rax
               	shrq	$0x3c, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r9, %rax
               	shrq	$0x8, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xabcd, %eax           # imm = 0xABCD
               	jne	<addr>
               	movq	%rdi, %rax
               	andq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	cmpl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	jne	<addr>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	cmpl	$0xf0, %eax
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r13, %rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0xf0f0f0, %ecx         # imm = 0xF0F0F0
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	jmp	<addr>
               	shlq	%rsi
               	leaq	-0x1(%rcx), %rax
               	andq	%rax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testb	$0x2d, %sil
               	je	<addr>
               	movq	%rcx, %rax
               	negq	%rax
               	andq	%rcx, %rax
               	orq	%rax, %rdx
               	jmp	<addr>
               	cmpl	$0x20d0, %edx           # imm = 0x20D0
               	jne	<addr>
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	movq	%r12, %rcx
               	jmp	<addr>
               	shlq	%rsi
               	leaq	-0x1(%rcx), %rax
               	andq	%rax, %rcx
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
               	jmp	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0xff00ff, %ecx         # imm = 0xFF00FF
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	movq	%rbx, %rax
               	andq	%rcx, %rax
               	movq	%rcx, %r15
               	negq	%r15
               	movl	%r15d, %r15d
               	andq	%r15, %rax
               	movq	%rdx, %r15
               	orq	%rsi, %r15
               	testq	%rax, %rax
               	cmovneq	%r15, %rdx
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
               	movq	%rcx, %r15
               	negq	%r15
               	movl	%r15d, %r15d
               	andq	%r15, %rax
               	movq	%rdx, %r15
               	orq	%rsi, %r15
               	testq	%rax, %rax
               	cmovneq	%r15, %rdx
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
               	jmp	<addr>
               	shlq	%rsi
               	leaq	-0x1(%rcx), %rax
               	andq	%rax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%r9, %rax
               	andq	%rsi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	negq	%rax
               	andq	%rcx, %rax
               	orq	%rax, %rdx
               	jmp	<addr>
               	movabsq	$-0x1100000000000000, %r11 # imm = 0xEF00000000000000
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0xfffffffffffff10, %rcx # imm = 0xF0000000000000F0
               	xorl	%eax, %eax
               	movl	$0x1, %edx
               	movq	%r9, %rsi
               	andq	%rcx, %rsi
               	movq	%rcx, %r15
               	negq	%r15
               	andq	%r15, %rsi
               	movq	%rax, %r15
               	orq	%rdx, %r15
               	testq	%rsi, %rsi
               	cmovneq	%r15, %rax
               	shlq	%rdx
               	leaq	-0x1(%rcx), %rsi
               	andq	%rsi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	$0xe, %rax
               	je	<addr>
               	orq	$0x10, %r8
               	xorl	%ecx, %ecx
               	movq	%r13, %rsi
               	imulq	%r9, %rsi
               	movq	%r13, %rax
               	mulq	%r9
               	movq	%r13, %rax
               	imulq	%rcx, %rax
               	imulq	%r9, %rcx
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
               	movq	%r14, %rsi
               	imulq	%r9, %rsi
               	movq	%r14, %rax
               	mulq	%r9
               	movq	%r14, %rax
               	imulq	%rcx, %rax
               	imulq	%r9, %rcx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	orq	$0x20, %r8
               	leaq	0x1(%rdi), %rcx
               	movl	%ecx, -0x8(%rbp)
               	movq	%rcx, %rax
               	shrq	$0x20, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	%edi, -0x8(%rbp)
               	leaq	0x1(%rbx), %rax
               	incq	%rax
               	movl	%eax, -0x8(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	%eax, %eax
               	leaq	0x2(%rbx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	(%rdi,%rdi), %rax
               	incq	%rax
               	movl	%eax, -0x8(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	%eax, %eax
               	cmpl	%edi, %eax
               	je	<addr>
               	orq	$0x40, %r8
               	leaq	-0x1(%r12), %rcx
               	movl	%ecx, -0x8(%rbp)
               	movq	%rcx, %rax
               	shrq	$0x3f, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	%ecx, %eax
               	cmpl	%edi, %eax
               	jne	<addr>
               	movl	$0x0, -0x8(%rbp)
               	leaq	(%r13,%r14), %rax
               	cmpq	%r13, %rax
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
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorl	%edi, %edi
               	movl	$0x1, %edx
               	leaq	-0x8(%rbp), %rcx
               	movq	%r9, 0x38(%rsp)
               	movq	%r8, 0x30(%rsp)
               	movq	%r14, %rsi
               	callq	<addr>
               	movq	0x38(%rsp), %r9
               	movq	0x30(%rsp), %r8
               	andq	$0xff, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	%r13, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	-0x8(%rbp), %rcx
               	movq	%r9, 0x38(%rsp)
               	movq	%r8, 0x30(%rsp)
               	movq	%r9, %rsi
               	movq	%rdi, %rdx
               	callq	<addr>
               	movq	0x38(%rsp), %r9
               	movq	0x30(%rsp), %r8
               	testb	$-0x1, %al
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	leaq	-0x2(%r9), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	(%r9,%r9), %rax
               	cmpq	%r9, %rax
               	movq	%rax, -0x8(%rbp)
               	jb	<addr>
               	movq	%r9, %rcx
               	shlq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	orq	$0x80, %r8
               	movq	%r8, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	orq	$0x8, %r8
               	jmp	<addr>
               	orq	$0x4, %r8
               	jmp	<addr>

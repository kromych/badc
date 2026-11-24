
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
               	subq	$0x30, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r8d, %r8d
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ebx # <addr>
               	movl	<rip>, %edi # <addr>
               	movq	<rip>, %r12 # <addr>
               	movq	<rip>, %r15 # <addr>
               	movq	<rip>, %r13 # <addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	bsrl	%ebx, %ecx
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
               	testq	%r15, %r15
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%r15, %rcx
               	cmovel	%r11d, %ecx
               	xorl	$0x3f, %ecx
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%r12, %rcx
               	cmovel	%r11d, %ecx
               	xorl	$0x3f, %ecx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	bsfl	%eax, %ecx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x1, %r8d
               	movq	%rax, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rdi, %rcx
               	cmpl	$0xff0f0f0f, %ecx       # imm = 0xFF0F0F0F
               	jne	<addr>
               	movq	%r12, %rcx
               	xorq	$-0x1, %rcx
               	movq	%rcx, %rdx
               	andq	%r13, %rdx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movq	%rax, %rcx
               	negq	%rcx
               	andq	%rax, %rcx
               	cmpl	$0x10, %ecx
               	jne	<addr>
               	leaq	-0x1(%rax), %rcx
               	movq	%rax, %rdx
               	xorq	%rcx, %rdx
               	cmpl	$0x1f, %edx
               	jne	<addr>
               	andq	%rax, %rcx
               	cmpl	$0xf0f0e0, %ecx         # imm = 0xF0F0E0
               	jne	<addr>
               	movq	%rbx, %rcx
               	negq	%rcx
               	andq	%rbx, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	-0x1(%rbx), %rcx
               	xorq	%rbx, %rcx
               	cmpl	$-0x1, %ecx
               	jne	<addr>
               	leaq	-0x1(%r12), %rcx
               	andq	%r12, %rcx
               	movabsq	$0x123456789abcdee, %r11 # imm = 0x123456789ABCDEE
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x1(%rcx), %rdx
               	xorq	%rdx, %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	orq	$0x2, %r8
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	andq	$0xff, %rcx
               	cmpl	$0xf, %ecx
               	jne	<addr>
               	movq	%rax, %rdx
               	shrq	$0x14, %rdx
               	cmpl	$0xf, %edx
               	jne	<addr>
               	cmpl	$0xf, %ecx
               	jne	<addr>
               	movq	%r12, %rcx
               	shrq	$0x3c, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%r12, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	$0xabcd, %ecx           # imm = 0xABCD
               	jne	<addr>
               	movq	%rdi, %rcx
               	andq	$0x7fffffff, %rcx       # imm = 0x7FFFFFFF
               	cmpl	$0x7fffffff, %ecx       # imm = 0x7FFFFFFF
               	jne	<addr>
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	cmpl	$0xf0, %ecx
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r13, %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0xf0f0f0, %ecx         # imm = 0xF0F0F0
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	jmp	<addr>
               	shlq	%rsi
               	leaq	-0x1(%rcx), %r9
               	andq	%r9, %rcx
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
               	movq	%rbx, %rcx
               	jmp	<addr>
               	shlq	%rsi
               	leaq	-0x1(%rcx), %r9
               	andq	%r9, %rcx
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
               	jmp	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0xff00ff, %ecx         # imm = 0xFF00FF
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	movq	%rax, %r9
               	andq	%rcx, %r9
               	movq	%rcx, %r14
               	negq	%r14
               	movl	%r14d, %r14d
               	andq	%r14, %r9
               	movq	%rdx, %r14
               	orq	%rsi, %r14
               	testq	%r9, %r9
               	cmovneq	%r14, %rdx
               	shlq	%rsi
               	leaq	-0x1(%rcx), %r9
               	andq	%r9, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	$0xf0f0, %edx           # imm = 0xF0F0
               	jne	<addr>
               	movl	$0x80000001, %ecx       # imm = 0x80000001
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	movq	%rdi, %r9
               	andq	%rcx, %r9
               	movq	%rcx, %r14
               	negq	%r14
               	movl	%r14d, %r14d
               	andq	%r14, %r9
               	movq	%rdx, %r14
               	orq	%rsi, %r14
               	testq	%r9, %r9
               	cmovneq	%r14, %rdx
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
               	movq	%r12, %r9
               	andq	%rsi, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	%rcx, %r9
               	negq	%r9
               	andq	%rcx, %r9
               	orq	%r9, %rdx
               	jmp	<addr>
               	movabsq	$-0x1100000000000000, %r11 # imm = 0xEF00000000000000
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0xfffffffffffff10, %rcx # imm = 0xF0000000000000F0
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	movq	%r12, %r9
               	andq	%rcx, %r9
               	movq	%rcx, %r14
               	negq	%r14
               	andq	%r14, %r9
               	movq	%rdx, %r14
               	orq	%rsi, %r14
               	testq	%r9, %r9
               	cmovneq	%r14, %rdx
               	shlq	%rsi
               	leaq	-0x1(%rcx), %r9
               	andq	%r9, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	$0xe, %rdx
               	je	<addr>
               	orq	$0x10, %r8
               	movq	%r13, %rcx
               	imulq	%r12, %rcx
               	movq	%rax, -0x18(%rsp)
               	movq	%r13, %rax
               	mulq	%r12
               	movq	-0x18(%rsp), %rax
               	movabsq	$-0x123456789abcdef, %r11 # imm = 0xFEDCBA9876543211
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$0x123456789abcdee, %r11 # imm = 0x123456789ABCDEE
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	%r15, %rcx
               	imulq	%r12, %rcx
               	movq	%rax, -0x18(%rsp)
               	movq	%r15, %rax
               	mulq	%r12
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
               	leaq	0x1(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	addq	$0x2, %rax
               	cmpl	%eax, %ecx
               	jne	<addr>
               	leaq	(%rdi,%rdi), %rax
               	incq	%rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	cmpl	%edi, %eax
               	je	<addr>
               	orq	$0x40, %r8
               	leaq	-0x1(%rbx), %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	cmpl	%edi, %eax
               	jne	<addr>
               	leaq	(%r13,%r15), %rax
               	cmpq	%r13, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	leaq	0x1(%rax), %rcx
               	cmpq	%rax, %rcx
               	setb	%al
               	movzbq	%al, %rax
               	addq	%rdx, %rax
               	movq	%rcx, 0x48(%rsp)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorl	%edi, %edi
               	movl	$0x1, %edx
               	leaq	0x48(%rsp), %rcx
               	movq	%r8, 0x38(%rsp)
               	movq	%r15, %rsi
               	callq	<addr>
               	movq	0x38(%rsp), %r8
               	andq	$0xff, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	0x48(%rsp), %rax
               	cmpq	%r13, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	0x48(%rsp), %rcx
               	movq	%r8, 0x38(%rsp)
               	movq	%r12, %rsi
               	movq	%rdi, %rdx
               	callq	<addr>
               	movq	0x38(%rsp), %r8
               	testb	$-0x1, %al
               	jne	<addr>
               	movq	0x48(%rsp), %rax
               	leaq	-0x2(%r12), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	(%r12,%r12), %rax
               	cmpq	%r12, %rax
               	movq	%rax, 0x48(%rsp)
               	jb	<addr>
               	movq	%r12, %rcx
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
               	addq	$0x30, %rsp
               	retq
               	orq	$0x8, %r8
               	jmp	<addr>
               	orq	$0x4, %r8
               	jmp	<addr>

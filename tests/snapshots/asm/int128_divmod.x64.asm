
int128_divmod.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	subq	$0x60, %rsp
               	andq	$-0x10, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	xorq	%r10, %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	<rip>, %r10
               	movq	%r10, -0x28(%rbp)
               	movq	-0x28(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x8(%rbp), %rdx
               	orq	%rax, %rdx
               	movq	%rcx, %rax
               	orq	-0x8(%rbp), %rax
               	movabsq	$-0x1, %rsi
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	<rip>, %r10
               	movq	%r10, -0x20(%rbp)
               	movq	-0x20(%rbp), %r10
               	movq	(%r10), %r13
               	xorq	%rdi, %rdi
               	movl	$0x80, %r8d
               	movq	%rdi, %r12
               	movq	%rsi, %rbx
               	movq	%rcx, %r9
               	jmp	<addr>
               	movq	%r9, %r14
               	shrq	$0x3f, %r14
               	movq	%r12, %r15
               	shlq	%r15
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r15, %r12
               	orq	%r14, %r12
               	movq	%rbx, %r10
               	shlq	%r10
               	movq	%r10, -0x10(%rbp)
               	shlq	%r9
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r9
               	testq	%rdi, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	testq	%rdi, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%r13, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %rbx
               	xorq	$0x1, %rbx
               	xorq	%r14, %r14
               	subq	%rbx, %r14
               	movq	%r13, %r15
               	andq	%r14, %r15
               	movq	%r14, %r10
               	movq	-0x8(%rbp), %r14
               	andq	%r10, %r14
               	cmpq	%r15, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x18(%rbp)
               	subq	%r15, %r12
               	subq	%r14, %rdi
               	subq	-0x18(%rbp), %rdi
               	movq	%rbx, %r10
               	movq	-0x10(%rbp), %rbx
               	orq	%r10, %rbx
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$-0x3333333333333334, %r11 # imm = 0xCCCCCCCCCCCCCCCC
               	movq	%rbx, %r8
               	cmpq	%r11, %rbx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$0xccccccccccccccc, %r11 # imm = 0xCCCCCCCCCCCCCCC
               	movq	%r9, %r8
               	cmpq	%r11, %r9
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x1, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	%edi, %rax
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	-0x20(%rbp), %r10
               	movq	(%r10), %rbx
               	xorq	%rdi, %rdi
               	movl	$0x80, %r8d
               	movq	%rdi, %r9
               	jmp	<addr>
               	movq	%rcx, %r12
               	shrq	$0x3f, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%rdi
               	shrq	$0x3f, %r9
               	orq	%r9, %rdi
               	movq	%r13, %r9
               	orq	%r12, %r9
               	movq	%rsi, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rcx
               	testq	%rdi, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	testq	%rdi, %rdi
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rbx, %r9
               	setb	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %r12
               	orq	%r12, %rsi
               	xorq	$0x1, %rsi
               	xorq	%r12, %r12
               	subq	%rsi, %r12
               	movq	%rbx, %r13
               	andq	%r12, %r13
               	andq	$0x0, %r12
               	cmpq	%r13, %r9
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r13, %r9
               	subq	%r12, %rdi
               	subq	%r15, %rdi
               	orq	%r14, %rsi
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	cmpq	$0x7, %r9
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rdi, %rdi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x2, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %esi
               	movl	$0x1, %edi
               	movq	%rax, %rcx
               	orq	%rdi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x80, %r8d
               	movq	%rcx, %rbx
               	movq	%rdx, %r9
               	movq	%rax, %r12
               	jmp	<addr>
               	movq	%r12, %r13
               	shrq	$0x3f, %r13
               	movq	%rbx, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %rbx
               	orq	%rbx, %rcx
               	movq	%r14, %rbx
               	orq	%r13, %rbx
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %r9
               	orq	%r9, %r12
               	cmpq	$0x1, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %rcx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x3, %rbx
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorq	%r13, %r13
               	subq	%r9, %r13
               	movq	%rsi, %r14
               	andq	%r13, %r14
               	andq	%rdi, %r13
               	cmpq	%r14, %rbx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x8(%rbp)
               	subq	%r14, %rbx
               	subq	%r13, %rcx
               	subq	-0x8(%rbp), %rcx
               	orq	%r15, %r9
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movq	%r12, %rcx
               	movabsq	$-0x7766554433221103, %r11 # imm = 0x8899AABBCCDDEEFD
               	cmpq	%r11, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	jne	<addr>
               	testq	%rcx, %rcx
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movl	$0x3, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	orq	%rdi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x80, %r8d
               	movq	%rcx, %r9
               	movq	%rdx, %rbx
               	movq	%rax, %r12
               	jmp	<addr>
               	movq	%r12, %r13
               	shrq	$0x3f, %r13
               	movq	%r9, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %r9
               	orq	%r9, %rcx
               	movq	%r14, %r9
               	orq	%r13, %r9
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r12
               	cmpq	$0x1, %rcx
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x1, %rcx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x3, %r9
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %rbx
               	xorq	$0x1, %rbx
               	xorq	%r13, %r13
               	subq	%rbx, %r13
               	movq	%rsi, %r14
               	andq	%r13, %r14
               	andq	%rdi, %r13
               	cmpq	%r14, %r9
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x8(%rbp)
               	subq	%r14, %r9
               	subq	%r13, %rcx
               	subq	-0x8(%rbp), %rcx
               	orq	%r15, %rbx
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$0x664421ffddbb9980, %r11 # imm = 0x664421FFDDBB9980
               	cmpq	%r11, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	jne	<addr>
               	testq	%rcx, %rcx
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movl	$0x4, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	-0x28(%rbp), %r10
               	movq	(%r10), %r8
               	xorq	%rcx, %rcx
               	xorq	%r9, %r9
               	movl	$0x80, %ebx
               	movq	%r9, %r12
               	jmp	<addr>
               	movq	%rcx, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%r9
               	shrq	$0x3f, %r12
               	orq	%r12, %r9
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r8, %r15
               	shlq	%r15
               	shlq	%rcx
               	shrq	$0x3f, %r8
               	orq	%r8, %rcx
               	cmpq	$0x1, %r9
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x1, %r9
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x3, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r8
               	xorq	$0x1, %r8
               	xorq	%r13, %r13
               	subq	%r8, %r13
               	movq	%rsi, %r14
               	andq	%r13, %r14
               	andq	%rdi, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x8(%rbp)
               	subq	%r14, %r12
               	subq	%r13, %r9
               	subq	-0x8(%rbp), %r9
               	orq	%r15, %r8
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	testq	%r8, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	testq	%rcx, %rcx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x5, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	-0x28(%rbp), %r10
               	movq	(%r10), %r9
               	xorq	%r8, %r8
               	xorq	%rcx, %rcx
               	movl	$0x80, %ebx
               	movq	%rcx, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %r12
               	orq	%r12, %rcx
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x1, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %rcx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x3, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorq	%r13, %r13
               	subq	%r9, %r13
               	movq	%rsi, %r14
               	andq	%r13, %r14
               	andq	%rdi, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x8(%rbp)
               	subq	%r14, %r12
               	subq	%r13, %rcx
               	subq	-0x8(%rbp), %rcx
               	orq	%r15, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	-0x28(%rbp), %r10
               	movq	(%r10), %r9
               	cmpq	%r9, %r12
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	jne	<addr>
               	testq	%rcx, %rcx
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movl	$0x6, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%rcx, %rcx
               	movl	$0x80, %ebx
               	movq	%rcx, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %r12
               	orq	%r12, %rcx
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	testq	%rcx, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rcx, %rcx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x7, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorq	%r13, %r13
               	subq	%r9, %r13
               	movq	%r13, %r14
               	andq	$0x7, %r14
               	andq	$0x0, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x8(%rbp)
               	subq	%r14, %r12
               	subq	%r13, %rcx
               	subq	-0x8(%rbp), %rcx
               	orq	%r15, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	xorq	$-0x1, %r9
               	xorq	$-0x1, %r8
               	cmpq	$-0x1, %r9
               	setb	%bl
               	movzbq	%bl, %rbx
               	incq	%r9
               	incq	%r8
               	movq	%rbx, %r10
               	movq	%r8, %rbx
               	subq	%r10, %rbx
               	movabsq	$-0x6db6db6db6db749a, %r11 # imm = 0x9249249249248B66
               	movq	%r9, %r8
               	cmpq	%r11, %r9
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$-0x6db6db6dc, %r11     # imm = 0xFFFFFFF924924924
               	movq	%rbx, %r8
               	cmpq	%r11, %rbx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x7, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%rcx, %rcx
               	movl	$0x80, %ebx
               	movq	%rcx, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %r12
               	orq	%r12, %rcx
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	testq	%rcx, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rcx, %rcx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x7, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorq	%r13, %r13
               	subq	%r9, %r13
               	movq	%r13, %r14
               	andq	$0x7, %r14
               	andq	$0x0, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x8(%rbp)
               	subq	%r14, %r12
               	subq	%r13, %rcx
               	subq	-0x8(%rbp), %rcx
               	orq	%r15, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r12, %r8
               	xorq	$-0x1, %r8
               	xorq	$-0x1, %rcx
               	cmpq	$-0x1, %r8
               	setb	%r9b
               	movzbq	%r9b, %r9
               	incq	%r8
               	incq	%rcx
               	movq	%r9, %r10
               	movq	%rcx, %r9
               	subq	%r10, %r9
               	cmpq	$-0x3, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	cmpq	$-0x1, %r9
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x8, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%r10, %r10
               	movq	%r10, -0x28(%rbp)
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%r15, %r15
               	xorq	%rcx, %rcx
               	movl	$0x80, %ebx
               	movq	%rcx, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %r12
               	orq	%r12, %rcx
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r10
               	shlq	%r10
               	movq	%r10, -0x8(%rbp)
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rcx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	testq	%r12, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorq	%r13, %r13
               	subq	%r9, %r13
               	movq	%r15, %r14
               	andq	%r13, %r14
               	andq	$0x40, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x10(%rbp)
               	subq	%r14, %r12
               	subq	%r13, %rcx
               	subq	-0x10(%rbp), %rcx
               	movq	%r9, %r10
               	movq	-0x8(%rbp), %r9
               	orq	%r10, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	xorq	%rbx, %rbx
               	xorq	%rbx, %r9
               	xorq	%rbx, %r8
               	testq	%r9, %r9
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	$0x0, %r9
               	subq	$0x0, %r8
               	movq	%rbx, %r10
               	movq	%r8, %rbx
               	subq	%r10, %rbx
               	movl	$0xc0000000, %r11d      # imm = 0xC0000000
               	movq	%r9, %r8
               	cmpq	%r11, %r9
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	testq	%rbx, %rbx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x9, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%r15, %r15
               	xorq	%rcx, %rcx
               	movl	$0x80, %ebx
               	movq	%rcx, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %r12
               	orq	%r12, %rcx
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r10
               	shlq	%r10
               	movq	%r10, -0x8(%rbp)
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rcx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	testq	%r12, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorq	%r13, %r13
               	subq	%r9, %r13
               	movq	%r15, %r14
               	andq	%r13, %r14
               	andq	$0x40, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x10(%rbp)
               	subq	%r14, %r12
               	subq	%r13, %rcx
               	subq	-0x10(%rbp), %rcx
               	movq	%r9, %r10
               	movq	-0x8(%rbp), %r9
               	orq	%r10, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r12, %r8
               	xorq	$-0x1, %r8
               	xorq	$-0x1, %rcx
               	cmpq	$-0x1, %r8
               	setb	%r9b
               	movzbq	%r9b, %r9
               	incq	%r8
               	incq	%rcx
               	movq	%r9, %r10
               	movq	%rcx, %r9
               	subq	%r10, %r9
               	cmpq	$-0x3039, %r8           # imm = 0xCFC7
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	cmpq	$-0x1, %r9
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0xa, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%r15, %r15
               	xorq	%rcx, %rcx
               	movl	$0x80, %ebx
               	movq	%rcx, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %r12
               	orq	%r12, %rcx
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r10
               	shlq	%r10
               	movq	%r10, -0x8(%rbp)
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rcx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	testq	%r12, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorq	%r13, %r13
               	subq	%r9, %r13
               	movq	%r15, %r14
               	andq	%r13, %r14
               	andq	$0x40, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x10(%rbp)
               	subq	%r14, %r12
               	subq	%r13, %rcx
               	subq	-0x10(%rbp), %rcx
               	movq	%r9, %r10
               	movq	-0x8(%rbp), %r9
               	orq	%r10, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	xorq	$-0x1, %r9
               	xorq	$-0x1, %r8
               	cmpq	$-0x1, %r9
               	setb	%bl
               	movzbq	%bl, %rbx
               	incq	%r9
               	incq	%r8
               	movq	%rbx, %r10
               	movq	%r8, %rbx
               	subq	%r10, %rbx
               	movabsq	$-0xc0000000, %r11      # imm = 0xFFFFFFFF40000000
               	movq	%r9, %r8
               	cmpq	%r11, %r9
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	cmpq	$-0x1, %rbx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0xb, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%r10, %r10
               	movq	%r10, -0x18(%rbp)
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%r15, %r15
               	xorq	%rcx, %rcx
               	movl	$0x80, %ebx
               	movq	%rcx, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %r12
               	orq	%r12, %rcx
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r10
               	shlq	%r10
               	movq	%r10, -0x8(%rbp)
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rcx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	testq	%r12, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorq	%r13, %r13
               	subq	%r9, %r13
               	movq	%r15, %r14
               	andq	%r13, %r14
               	andq	$0x40, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x10(%rbp)
               	subq	%r14, %r12
               	subq	%r13, %rcx
               	subq	-0x10(%rbp), %rcx
               	movq	%r9, %r10
               	movq	-0x8(%rbp), %r9
               	orq	%r10, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r12, %r8
               	xorq	-0x18(%rbp), %r8
               	xorq	-0x18(%rbp), %rcx
               	testq	%r8, %r8
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	$0x0, %r8
               	subq	$0x0, %rcx
               	movq	%r9, %r10
               	movq	%rcx, %r9
               	subq	%r10, %r9
               	cmpq	$0x3039, %r8            # imm = 0x3039
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	testq	%r9, %r9
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0xc, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	-0x20(%rbp), %r10
               	movq	(%r10), %r13
               	xorq	%r10, %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rax, %rcx
               	orq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x80, %r8d
               	movq	%rcx, %rbx
               	movq	%rdx, %r9
               	movq	%rax, %r12
               	jmp	<addr>
               	movq	%r12, %r14
               	shrq	$0x3f, %r14
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%rcx
               	shrq	$0x3f, %rbx
               	orq	%rbx, %rcx
               	movq	%r15, %rbx
               	orq	%r14, %rbx
               	movq	%r9, %r10
               	shlq	%r10
               	movq	%r10, -0x10(%rbp)
               	shlq	%r12
               	shrq	$0x3f, %r9
               	orq	%r9, %r12
               	testq	%rcx, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rcx, %rcx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%r13, %rbx
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorq	%r14, %r14
               	subq	%r9, %r14
               	movq	%r13, %r15
               	andq	%r14, %r15
               	movq	%r14, %r10
               	movq	-0x8(%rbp), %r14
               	andq	%r10, %r14
               	cmpq	%r15, %rbx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x18(%rbp)
               	subq	%r15, %rbx
               	subq	%r14, %rcx
               	subq	-0x18(%rbp), %rcx
               	movq	%r9, %r10
               	movq	-0x10(%rbp), %r9
               	orq	%r10, %r9
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movq	%r12, %rcx
               	movq	-0x20(%rbp), %r10
               	movq	(%r10), %r8
               	xorq	%r10, %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%r9, %r10
               	imulq	%r8, %r10
               	movq	%r10, -0x30(%rbp)
               	movl	%r9d, %ebx
               	movq	%r9, %r12
               	shrq	$0x20, %r12
               	movl	%r8d, %r13d
               	movq	%r8, %r14
               	shrq	$0x20, %r14
               	movq	%rbx, %r15
               	imulq	%r13, %r15
               	shrq	$0x20, %r15
               	imulq	%r12, %r13
               	addq	%r15, %r13
               	movl	%r13d, %r15d
               	shrq	$0x20, %r13
               	imulq	%r14, %rbx
               	addq	%r15, %rbx
               	shrq	$0x20, %rbx
               	imulq	%r14, %r12
               	addq	%r13, %r12
               	addq	%r12, %rbx
               	imulq	-0x8(%rbp), %r9
               	imulq	%r8, %rcx
               	leaq	(%rbx,%r9), %r8
               	leaq	(%r8,%rcx), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	-0x20(%rbp), %r10
               	movq	(%r10), %r13
               	movq	%rax, %rcx
               	orq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x80, %r8d
               	movq	%rcx, %r9
               	movq	%rdx, %rbx
               	movq	%rax, %r12
               	jmp	<addr>
               	movq	%r12, %r14
               	shrq	$0x3f, %r14
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%rcx
               	shrq	$0x3f, %r9
               	orq	%r9, %rcx
               	movq	%r15, %r9
               	orq	%r14, %r9
               	movq	%rbx, %r10
               	shlq	%r10
               	movq	%r10, -0x10(%rbp)
               	shlq	%r12
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r12
               	testq	%rcx, %rcx
               	setb	%bl
               	movzbq	%bl, %rbx
               	testq	%rcx, %rcx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%r13, %r9
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %rbx
               	xorq	$0x1, %rbx
               	xorq	%r14, %r14
               	subq	%rbx, %r14
               	movq	%r13, %r15
               	andq	%r14, %r15
               	movq	%r14, %r10
               	movq	-0x8(%rbp), %r14
               	andq	%r10, %r14
               	cmpq	%r15, %r9
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x18(%rbp)
               	subq	%r15, %r9
               	subq	%r14, %rcx
               	subq	-0x18(%rbp), %rcx
               	movq	%rbx, %r10
               	movq	-0x10(%rbp), %rbx
               	orq	%r10, %rbx
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movq	-0x30(%rbp), %r8
               	addq	%r9, %r8
               	cmpq	-0x30(%rbp), %r8
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%rcx, %r10
               	movq	-0x38(%rbp), %rcx
               	addq	%r10, %rcx
               	addq	%rcx, %r9
               	movq	%rdx, %rcx
               	xorq	%r8, %rcx
               	movq	%rax, %r8
               	xorq	%r9, %r8
               	orq	%r8, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%r15, %r15
               	xorq	%rcx, %rcx
               	movl	$0x80, %ebx
               	movq	%rcx, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %r12
               	orq	%r12, %rcx
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r10
               	shlq	%r10
               	movq	%r10, -0x8(%rbp)
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rcx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	testq	%r12, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorq	%r13, %r13
               	subq	%r9, %r13
               	movq	%r15, %r14
               	andq	%r13, %r14
               	andq	$0x40, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x10(%rbp)
               	subq	%r14, %r12
               	subq	%r13, %rcx
               	subq	-0x10(%rbp), %rcx
               	movq	%r9, %r10
               	movq	-0x8(%rbp), %r9
               	orq	%r10, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	xorq	%rbx, %rbx
               	xorq	%rbx, %r9
               	xorq	%r8, %rbx
               	testq	%r9, %r9
               	setb	%r13b
               	movzbq	%r13b, %r13
               	leaq	(%r9), %r8
               	leaq	(%rbx), %r9
               	movq	%r13, %r10
               	movq	%r9, %r13
               	subq	%r10, %r13
               	movq	%r8, %r10
               	imulq	-0x28(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movl	%r8d, %ecx
               	movq	%r8, %r9
               	shrq	$0x20, %r9
               	xorq	%rbx, %rbx
               	xorq	%r12, %r12
               	movq	%rcx, %r14
               	imulq	%rbx, %r14
               	shrq	$0x20, %r14
               	imulq	%r9, %rbx
               	addq	%r14, %rbx
               	movl	%ebx, %r14d
               	shrq	$0x20, %rbx
               	imulq	%r12, %rcx
               	addq	%r14, %rcx
               	shrq	$0x20, %rcx
               	imulq	%r12, %r9
               	addq	%rbx, %r9
               	addq	%r9, %rcx
               	imulq	$-0x40, %r8, %r8
               	movq	%r13, %r9
               	imulq	-0x28(%rbp), %r9
               	addq	%r8, %rcx
               	leaq	(%rcx,%r9), %r10
               	movq	%r10, -0x28(%rbp)
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%r15, %r15
               	xorq	%rcx, %rcx
               	movl	$0x80, %ebx
               	movq	%rcx, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %r12
               	orq	%r12, %rcx
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r10
               	shlq	%r10
               	movq	%r10, -0x8(%rbp)
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rcx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	testq	%r12, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorq	%r13, %r13
               	subq	%r9, %r13
               	movq	%r15, %r14
               	andq	%r13, %r14
               	andq	$0x40, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x10(%rbp)
               	subq	%r14, %r12
               	subq	%r13, %rcx
               	subq	-0x10(%rbp), %rcx
               	movq	%r9, %r10
               	movq	-0x8(%rbp), %r9
               	orq	%r10, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r12, %r8
               	xorq	$-0x1, %r8
               	xorq	$-0x1, %rcx
               	cmpq	$-0x1, %r8
               	setb	%r9b
               	movzbq	%r9b, %r9
               	incq	%r8
               	incq	%rcx
               	movq	%r9, %r10
               	movq	%rcx, %r9
               	subq	%r10, %r9
               	movq	%r8, %r10
               	movq	-0x18(%rbp), %r8
               	addq	%r10, %r8
               	cmpq	-0x18(%rbp), %r8
               	setb	%cl
               	movzbq	%cl, %rcx
               	movq	%r9, %r10
               	movq	-0x28(%rbp), %r9
               	addq	%r10, %r9
               	addq	%rcx, %r9
               	movq	%r8, %rcx
               	xorq	$-0x3039, %rcx          # imm = 0xCFC7
               	movabsq	$-0x3000000001, %r8     # imm = 0xFFFFFFCFFFFFFFFF
               	xorq	%r9, %r8
               	orq	%r8, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	-0x20(%rbp), %r10
               	movq	(%r10), %rbx
               	xorq	%r14, %r14
               	movq	%rax, %rcx
               	orq	%r14, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x80, %r9d
               	movq	%rdx, %r8
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rax, %r12
               	shrq	$0x3f, %r12
               	movq	%rdx, %r13
               	shlq	%r13
               	shlq	%rcx
               	shrq	$0x3f, %rdx
               	orq	%rdx, %rcx
               	movq	%r13, %rdx
               	orq	%r12, %rdx
               	movq	%r8, %r15
               	shlq	%r15
               	shlq	%rax
               	shrq	$0x3f, %r8
               	orq	%r8, %rax
               	testq	%rcx, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	testq	%rcx, %rcx
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rbx, %rdx
               	setb	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %r12
               	orq	%r12, %r8
               	xorq	$0x1, %r8
               	xorq	%r12, %r12
               	subq	%r8, %r12
               	movq	%rbx, %r13
               	andq	%r12, %r13
               	andq	%r14, %r12
               	cmpq	%r13, %rdx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x8(%rbp)
               	subq	%r13, %rdx
               	subq	%r12, %rcx
               	subq	-0x8(%rbp), %rcx
               	orq	%r15, %r8
               	decq	%r9
               	testq	%r9, %r9
               	jne	<addr>
               	movq	%rax, %rcx
               	movq	%rcx, %rax
               	orq	%rdi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%r8, %r9
               	movq	%rax, %r8
               	jmp	<addr>
               	movq	%rcx, %rbx
               	shrq	$0x3f, %rbx
               	movq	%r8, %r12
               	shlq	%r12
               	shlq	%rax
               	shrq	$0x3f, %r8
               	orq	%r8, %rax
               	movq	%r12, %r8
               	orq	%rbx, %r8
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%rcx
               	shrq	$0x3f, %r9
               	orq	%r9, %rcx
               	cmpq	$0x1, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x3, %r8
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %r9
               	xorq	$0x1, %r9
               	xorq	%rbx, %rbx
               	subq	%r9, %rbx
               	movq	%rsi, %r12
               	andq	%rbx, %r12
               	andq	%rdi, %rbx
               	cmpq	%r12, %r8
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %r8
               	subq	%rbx, %rax
               	subq	%r14, %rax
               	orq	%r13, %r9
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$-0x4292c96669d3a3d8, %r11 # imm = 0xBD6D3699962C5C28
               	movq	%r8, %rdx
               	cmpq	%r11, %r8
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xf, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	popq	%rax
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r13
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r13
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	xorq	%rcx, %rcx
               	movq	%rcx, %r12
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r13
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r13
               	movq	%rdx, %rbx
               	popq	%rdx
               	popq	%rax
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	xorq	%rcx, %rcx
               	movq	%rcx, %r12
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rbx
               	popq	%rdx
               	popq	%rax
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	jmp	<addr>

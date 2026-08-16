
int128_divmod.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	xorq	%rdx, %rdx
               	leaq	<rip>, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	movq	(%r10), %rax
               	movq	%rdx, %rcx
               	orq	%rax, %rcx
               	movq	%rsi, %rax
               	orq	%rdx, %rax
               	movabsq	$-0x1, %rsi
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	<rip>, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %r13
               	xorq	%rdi, %rdi
               	movl	$0x80, %r8d
               	movq	%rdi, %r12
               	movq	%rsi, %rbx
               	movq	%rdx, %r9
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
               	movq	%rbx, %r15
               	shlq	%r15
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
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	andq	0x58(%rsp), %r14
               	orq	%r14, %rbx
               	xorq	$0x1, %rbx
               	xorq	%r14, %r14
               	subq	%rbx, %r14
               	andq	%r13, %r14
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r12
               	subq	$0x0, %rdi
               	subq	0x58(%rsp), %rdi
               	orq	%r15, %rbx
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$-0x3333333333333334, %r11 # imm = 0xCCCCCCCCCCCCCCCC
               	movq	%rbx, %rdi
               	cmpq	%r11, %rbx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movabsq	$0xccccccccccccccc, %r11 # imm = 0xCCCCCCCCCCCCCCC
               	movq	%r9, %rdi
               	cmpq	%r11, %r9
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x1, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	%edi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %rbx
               	xorq	%rdi, %rdi
               	movl	$0x80, %r8d
               	movq	%rdi, %r9
               	jmp	<addr>
               	movq	%rdx, %r12
               	shrq	$0x3f, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%rdi
               	shrq	$0x3f, %r9
               	orq	%r9, %rdi
               	movq	%r13, %r9
               	orq	%r12, %r9
               	movq	%rsi, %r13
               	shlq	%r13
               	shlq	%rdx
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rdx
               	testq	%rdi, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	testq	%rdi, %rdi
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rbx, %r9
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r12
               	orq	%r12, %rsi
               	xorq	$0x1, %rsi
               	xorq	%r12, %r12
               	subq	%rsi, %r12
               	andq	%rbx, %r12
               	cmpq	%r12, %r9
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %r9
               	subq	$0x0, %rdi
               	subq	%r14, %rdi
               	orq	%r13, %rsi
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	cmpq	$0x7, %r9
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	testq	%rdi, %rdi
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	%edx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edx
               	movl	$0x1, %esi
               	movq	%rax, %rdi
               	orq	%rsi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorq	%rdi, %rdi
               	movl	$0x80, %r8d
               	movq	%rdi, %rbx
               	movq	%rcx, %r9
               	movq	%rax, %r12
               	jmp	<addr>
               	movq	%r12, %r13
               	shrq	$0x3f, %r13
               	movq	%rbx, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %rbx
               	orq	%rbx, %rdi
               	movq	%r14, %rbx
               	orq	%r13, %rbx
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %r9
               	orq	%r9, %r12
               	cmpq	$0x1, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %rdi
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
               	movq	%rdx, %r14
               	andq	%r13, %r14
               	andq	%rsi, %r13
               	cmpq	%r14, %rbx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %rbx
               	subq	%r13, %rdi
               	subq	0x58(%rsp), %rdi
               	orq	%r15, %r9
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$-0x7766554433221103, %r11 # imm = 0x8899AABBCCDDEEFD
               	movq	%r9, %rdi
               	cmpq	%r11, %r9
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	testq	%r12, %r12
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x3, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	%edi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdi
               	orq	%rsi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorq	%rdi, %rdi
               	movl	$0x80, %r8d
               	movq	%rdi, %r9
               	movq	%rcx, %rbx
               	movq	%rax, %r12
               	jmp	<addr>
               	movq	%r12, %r13
               	shrq	$0x3f, %r13
               	movq	%r9, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r9
               	orq	%r9, %rdi
               	movq	%r14, %r9
               	orq	%r13, %r9
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r12
               	cmpq	$0x1, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x1, %rdi
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
               	movq	%rdx, %r14
               	andq	%r13, %r14
               	andq	%rsi, %r13
               	cmpq	%r14, %r9
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r9
               	subq	%r13, %rdi
               	subq	0x58(%rsp), %rdi
               	orq	%r15, %rbx
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$0x664421ffddbb9980, %r11 # imm = 0x664421FFDDBB9980
               	movq	%r9, %r8
               	cmpq	%r11, %r9
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	testq	%rdi, %rdi
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x4, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	%edi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	0x48(%rsp), %r10
               	movq	(%r10), %r8
               	xorq	%rdi, %rdi
               	xorq	%r9, %r9
               	movl	$0x80, %ebx
               	movq	%r9, %r12
               	jmp	<addr>
               	movq	%rdi, %r13
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
               	shlq	%rdi
               	shrq	$0x3f, %r8
               	orq	%r8, %rdi
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
               	movq	%rdx, %r14
               	andq	%r13, %r14
               	andq	%rsi, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r12
               	subq	%r13, %r9
               	subq	0x58(%rsp), %r9
               	orq	%r15, %r8
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	testq	%r8, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	testq	%rdi, %rdi
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x5, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	%edi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	0x48(%rsp), %r10
               	movq	(%r10), %r9
               	xorq	%r8, %r8
               	xorq	%rdi, %rdi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x1, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %rdi
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
               	movq	%rdx, %r14
               	andq	%r13, %r14
               	andq	%rsi, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r12
               	subq	%r13, %rdi
               	subq	0x58(%rsp), %rdi
               	orq	%r15, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	0x48(%rsp), %r10
               	movq	(%r10), %r8
               	cmpq	%r8, %r12
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	testq	%rdi, %rdi
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x6, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	%edi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%rdi, %rdi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r14
               	shlq	%r14
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	testq	%rdi, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rdi, %rdi
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x7, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorq	%r13, %r13
               	subq	%r9, %r13
               	andq	$0x7, %r13
               	cmpq	%r13, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r13, %r12
               	subq	$0x0, %rdi
               	subq	%r15, %rdi
               	orq	%r14, %r9
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
               	movq	%r9, %rdi
               	cmpq	%r11, %r9
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movabsq	$-0x6db6db6dc, %r11     # imm = 0xFFFFFFF924924924
               	movq	%rbx, %rdi
               	cmpq	%r11, %rbx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x7, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	%edi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%rdi, %rdi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r14
               	shlq	%r14
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	testq	%rdi, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rdi, %rdi
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x7, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorq	%r13, %r13
               	subq	%r9, %r13
               	andq	$0x7, %r13
               	cmpq	%r13, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r13, %r12
               	subq	$0x0, %rdi
               	subq	%r15, %rdi
               	orq	%r14, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r12, %r8
               	xorq	$-0x1, %r8
               	xorq	$-0x1, %rdi
               	cmpq	$-0x1, %r8
               	setb	%r9b
               	movzbq	%r9b, %r9
               	incq	%r8
               	incq	%rdi
               	movq	%r9, %r10
               	movq	%rdi, %r9
               	subq	%r10, %r9
               	cmpq	$-0x3, %r8
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	$-0x1, %r9
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x8, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	%edi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%r10, %r10
               	movq	%r10, 0x48(%rsp)
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%rdi, %rdi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorq	%r14, %r14
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	$0x0, %r12
               	subq	%r14, %rdi
               	subq	%r15, %rdi
               	orq	%r13, %r9
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
               	movq	%r9, %rdi
               	cmpq	%r11, %r9
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	testq	%rbx, %rbx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x9, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	%edi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%rdi, %rdi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorq	%r14, %r14
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	$0x0, %r12
               	subq	%r14, %rdi
               	subq	%r15, %rdi
               	orq	%r13, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r12, %r8
               	xorq	$-0x1, %r8
               	xorq	$-0x1, %rdi
               	cmpq	$-0x1, %r8
               	setb	%r9b
               	movzbq	%r9b, %r9
               	incq	%r8
               	incq	%rdi
               	movq	%r9, %r10
               	movq	%rdi, %r9
               	subq	%r10, %r9
               	cmpq	$-0x3039, %r8           # imm = 0xCFC7
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	$-0x1, %r9
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xa, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	%edi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%rdi, %rdi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorq	%r14, %r14
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	$0x0, %r12
               	subq	%r14, %rdi
               	subq	%r15, %rdi
               	orq	%r13, %r9
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
               	movq	%r9, %rdi
               	cmpq	%r11, %r9
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	$-0x1, %rbx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xb, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	%edi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%r10, %r10
               	movq	%r10, 0x58(%rsp)
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%rdi, %rdi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorq	%r14, %r14
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	$0x0, %r12
               	subq	%r14, %rdi
               	subq	%r15, %rdi
               	orq	%r13, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r12, %r8
               	xorq	0x58(%rsp), %r8
               	xorq	0x58(%rsp), %rdi
               	testq	%r8, %r8
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	$0x0, %r8
               	subq	$0x0, %rdi
               	movq	%r9, %r10
               	movq	%rdi, %r9
               	subq	%r10, %r9
               	cmpq	$0x3039, %r8            # imm = 0x3039
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	testq	%r9, %r9
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xc, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	%edi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %r13
               	movq	%rax, %rdi
               	orq	$0x0, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorq	%rdi, %rdi
               	movl	$0x80, %r8d
               	movq	%rdi, %rbx
               	movq	%rcx, %r9
               	movq	%rax, %r12
               	jmp	<addr>
               	movq	%r12, %r14
               	shrq	$0x3f, %r14
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%rdi
               	shrq	$0x3f, %rbx
               	orq	%rbx, %rdi
               	movq	%r15, %rbx
               	orq	%r14, %rbx
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %r9
               	orq	%r9, %r12
               	testq	%rdi, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rdi, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%r13, %rbx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	andq	0x58(%rsp), %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorq	%r14, %r14
               	subq	%r9, %r14
               	andq	%r13, %r14
               	cmpq	%r14, %rbx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %rbx
               	subq	$0x0, %rdi
               	subq	0x58(%rsp), %rdi
               	orq	%r15, %r9
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %rdi
               	xorq	%r8, %r8
               	movq	%r9, %r10
               	imulq	%rdi, %r10
               	movq	%r10, 0x40(%rsp)
               	movl	%r9d, %ebx
               	movq	%r9, %r13
               	shrq	$0x20, %r13
               	movl	%edi, %r14d
               	movq	%rdi, %r15
               	shrq	$0x20, %r15
               	movq	%rbx, %r10
               	imulq	%r14, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x58(%rsp)
               	imulq	%r13, %r14
               	addq	0x58(%rsp), %r14
               	movl	%r14d, %r10d
               	movq	%r10, 0x58(%rsp)
               	shrq	$0x20, %r14
               	imulq	%r15, %rbx
               	addq	0x58(%rsp), %rbx
               	shrq	$0x20, %rbx
               	imulq	%r15, %r13
               	addq	%r14, %r13
               	addq	%r13, %rbx
               	imulq	%r8, %r9
               	imulq	%r12, %rdi
               	addq	%rbx, %r9
               	leaq	(%r9,%rdi), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %r13
               	movq	%rax, %rdi
               	orq	%r8, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorq	%rdi, %rdi
               	movl	$0x80, %r8d
               	movq	%rdi, %r9
               	movq	%rcx, %rbx
               	movq	%rax, %r12
               	jmp	<addr>
               	movq	%r12, %r14
               	shrq	$0x3f, %r14
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%rdi
               	shrq	$0x3f, %r9
               	orq	%r9, %rdi
               	movq	%r15, %r9
               	orq	%r14, %r9
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r12
               	testq	%rdi, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	testq	%rdi, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%r13, %r9
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	andq	0x58(%rsp), %r14
               	orq	%r14, %rbx
               	xorq	$0x1, %rbx
               	xorq	%r14, %r14
               	subq	%rbx, %r14
               	andq	%r13, %r14
               	cmpq	%r14, %r9
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r9
               	subq	$0x0, %rdi
               	subq	0x58(%rsp), %rdi
               	orq	%r15, %rbx
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movq	0x40(%rsp), %r8
               	addq	%r9, %r8
               	cmpq	0x40(%rsp), %r8
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%rdi, %r10
               	movq	0x38(%rsp), %rdi
               	addq	%r10, %rdi
               	addq	%rdi, %r9
               	movq	%rcx, %rdi
               	xorq	%r8, %rdi
               	movq	%rax, %r8
               	xorq	%r9, %r8
               	orq	%r8, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%rdi, %rdi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorq	%r14, %r14
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	$0x0, %r12
               	subq	%r14, %rdi
               	subq	%r15, %rdi
               	orq	%r13, %r9
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
               	imulq	0x48(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movl	%r8d, %edi
               	movq	%r8, %r9
               	shrq	$0x20, %r9
               	xorq	%rbx, %rbx
               	xorq	%r12, %r12
               	movq	%rdi, %r14
               	imulq	%rbx, %r14
               	shrq	$0x20, %r14
               	imulq	%r9, %rbx
               	addq	%r14, %rbx
               	movl	%ebx, %r14d
               	shrq	$0x20, %rbx
               	imulq	%r12, %rdi
               	addq	%r14, %rdi
               	shrq	$0x20, %rdi
               	imulq	%r12, %r9
               	addq	%rbx, %r9
               	addq	%r9, %rdi
               	imulq	$-0x40, %r8, %r8
               	movq	%r13, %r9
               	imulq	0x48(%rsp), %r9
               	addq	%r8, %rdi
               	leaq	(%rdi,%r9), %r10
               	movq	%r10, 0x48(%rsp)
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorq	%rdi, %rdi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	jmp	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorq	%r14, %r14
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	$0x0, %r12
               	subq	%r14, %rdi
               	subq	%r15, %rdi
               	orq	%r13, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r12, %r8
               	xorq	$-0x1, %r8
               	xorq	$-0x1, %rdi
               	cmpq	$-0x1, %r8
               	setb	%r9b
               	movzbq	%r9b, %r9
               	incq	%r8
               	incq	%rdi
               	movq	%r9, %r10
               	movq	%rdi, %r9
               	subq	%r10, %r9
               	movq	%r8, %r10
               	movq	0x58(%rsp), %r8
               	addq	%r10, %r8
               	cmpq	0x58(%rsp), %r8
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%r9, %r10
               	movq	0x48(%rsp), %r9
               	addq	%r10, %r9
               	addq	%rdi, %r9
               	movq	%r8, %rdi
               	xorq	$-0x3039, %rdi          # imm = 0xCFC7
               	movabsq	$-0x3000000001, %r8     # imm = 0xFFFFFFCFFFFFFFFF
               	xorq	%r9, %r8
               	orq	%r8, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %rbx
               	movq	%rax, %rdi
               	orq	$0x0, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorq	%r8, %r8
               	movl	$0x80, %r9d
               	movq	%rcx, %rdi
               	movq	%r8, %rcx
               	jmp	<addr>
               	movq	%rax, %r12
               	shrq	$0x3f, %r12
               	movq	%rcx, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %rcx
               	orq	%rcx, %r8
               	movq	%r13, %rcx
               	orq	%r12, %rcx
               	movq	%rdi, %r13
               	shlq	%r13
               	shlq	%rax
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rax
               	testq	%r8, %r8
               	setb	%dil
               	movzbq	%dil, %rdi
               	testq	%r8, %r8
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rbx, %rcx
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r12
               	orq	%r12, %rdi
               	xorq	$0x1, %rdi
               	xorq	%r12, %r12
               	subq	%rdi, %r12
               	andq	%rbx, %r12
               	cmpq	%r12, %rcx
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %rcx
               	subq	$0x0, %r8
               	subq	%r14, %r8
               	orq	%r13, %rdi
               	decq	%r9
               	testq	%r9, %r9
               	jne	<addr>
               	movq	%rax, %rcx
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x80, %r8d
               	movq	%rdi, %r9
               	movq	%rcx, %rdi
               	jmp	<addr>
               	movq	%rax, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rdi, %r12
               	shlq	%r12
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	movq	%r12, %rdi
               	orq	%rbx, %rdi
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%rax
               	shrq	$0x3f, %r9
               	orq	%r9, %rax
               	cmpq	$0x1, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %rcx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x3, %rdi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %r9
               	xorq	$0x1, %r9
               	xorq	%rbx, %rbx
               	subq	%r9, %rbx
               	movq	%rdx, %r12
               	andq	%rbx, %r12
               	andq	%rsi, %rbx
               	cmpq	%r12, %rdi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %rdi
               	subq	%rbx, %rcx
               	subq	%r14, %rcx
               	orq	%r13, %r9
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$-0x4292c96669d3a3d8, %r11 # imm = 0xBD6D3699962C5C28
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r13
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r13
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	xorq	%rdi, %rdi
               	movq	%rdi, %r12
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r13
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r13
               	movq	%rdx, %rbx
               	popq	%rdx
               	popq	%rax
               	xorq	%rdi, %rdi
               	movq	%rdi, %r12
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	xorq	%rdi, %rdi
               	movq	%rdi, %r12
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rbx
               	popq	%rdx
               	popq	%rax
               	xorq	%rdi, %rdi
               	movq	%rdi, %r12
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	jmp	<addr>

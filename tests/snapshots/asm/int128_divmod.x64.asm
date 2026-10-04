
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
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	xorl	%r8d, %r8d
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	%r8, %rsi
               	orq	%rax, %rsi
               	movq	$-0x1, %rax
               	movabsq	$0x7fffffffffffffff, %rdi # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	<rip>, %rdx      # <addr>
               	movq	(%rdx), %r9
               	cmpq	%r9, %rdi
               	jb	<addr>
               	pushq	%rax
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %rbx
               	imulq	%r9, %rbx
               	negq	%rbx
               	addq	%rdi, %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rbx, %rdx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movabsq	$-0x3333333333333334, %r11 # imm = 0xCCCCCCCCCCCCCCCC
               	cmpq	%r11, %r9
               	jne	<addr>
               	movabsq	$0xccccccccccccccc, %r11 # imm = 0xCCCCCCCCCCCCCCC
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x1, %r8d
               	testq	%r8, %r8
               	je	<addr>
               	movq	%r8, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movq	(%rdx), %r8
               	cmpq	%r8, %rdi
               	jb	<addr>
               	pushq	%rax
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rax
               	pushq	%rax
               	movq	%rdi, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	imulq	%r8, %rdx
               	subq	%rdx, %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movl	$0x1, %r9d
               	movq	%rcx, %rdx
               	orq	%r9, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %r8 # imm = 0x8000000000000001
               	movq	%rcx, %rax
               	shrq	%rax
               	movq	%rsi, %rbx
               	shrq	%rbx
               	movq	%rcx, %r12
               	shlq	$0x3f, %r12
               	orq	%r12, %rbx
               	pushq	%rdx
               	movq	%rax, %rdx
               	movq	%rbx, %rax
               	divq	%r8
               	popq	%rdx
               	testq	%rax, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	addq	%rax, %r8
               	pushq	%rdx
               	movq	%r8, %rax
               	mulq	%rdi
               	movq	%rdx, %rbx
               	popq	%rdx
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	addq	%r8, %rbx
               	cmpq	%rax, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	movq	%rsi, %r13
               	subq	%rax, %r13
               	movq	%rcx, %rax
               	subq	%rbx, %rax
               	subq	%r12, %rax
               	cmpq	$0x1, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x3, %r13
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rax
               	orq	%rbx, %rax
               	xorq	$0x1, %rax
               	addq	%r8, %rax
               	movabsq	$-0x7766554433221103, %r11 # imm = 0x8899AABBCCDDEEFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	testq	%rdx, %rdx
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %r8 # imm = 0x8000000000000001
               	movq	%rcx, %rdx
               	shrq	%rdx
               	movq	%rsi, %rax
               	shrq	%rax
               	movq	%rcx, %rbx
               	shlq	$0x3f, %rbx
               	orq	%rbx, %rax
               	divq	%r8
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	%r8, %rax
               	mulq	%rdi
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	addq	%r8, %rdx
               	cmpq	%rax, %rsi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	negq	%rax
               	addq	%rsi, %rax
               	negq	%rdx
               	addq	%rcx, %rdx
               	negq	%r8
               	addq	%rdx, %r8
               	cmpq	$0x1, %r8
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %r8
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x3, %rax
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %rdx
               	xorq	$0x1, %rdx
               	negq	%rdx
               	movq	%rdi, %rbx
               	andq	%rdx, %rbx
               	movq	%r9, %r12
               	andq	%rdx, %r12
               	cmpq	%rbx, %rax
               	setb	%r13b
               	movzbq	%r13b, %r13
               	movq	%rax, %rdx
               	subq	%rbx, %rdx
               	movq	%r8, %rax
               	subq	%r12, %rax
               	subq	%r13, %rax
               	movabsq	$0x664421ffddbb9980, %r11 # imm = 0x664421FFDDBB9980
               	cmpq	%r11, %rdx
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movabsq	$-0x7fffffffffffffff, %r8 # imm = 0x8000000000000001
               	xorl	%edx, %edx
               	movq	%rax, %rbx
               	shrq	%rbx
               	pushq	%rax
               	movq	%rbx, %rax
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	testq	%rdx, %rdx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	addq	%rdx, %r8
               	pushq	%rax
               	movq	%r8, %rax
               	mulq	%rdi
               	movq	%rdx, %rbx
               	popq	%rax
               	movq	%r8, %rdx
               	imulq	%rdi, %rdx
               	addq	%r8, %rbx
               	cmpq	%rdx, %rax
               	setb	%r12b
               	movzbq	%r12b, %r12
               	negq	%rdx
               	addq	%rax, %rdx
               	movq	%rbx, %rax
               	negq	%rax
               	subq	%r12, %rax
               	cmpq	$0x1, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x3, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rax
               	orq	%rbx, %rax
               	xorq	$0x1, %rax
               	addq	%r8, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r8
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	xorl	%edx, %edx
               	movq	%r8, %rbx
               	shrq	%rbx
               	movq	%rax, %r11
               	movq	%rbx, %rax
               	divq	%r11
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	subq	%rdx, %rax
               	pushq	%rax
               	mulq	%rdi
               	movq	%rdx, %rbx
               	popq	%rax
               	movq	%rax, %rdx
               	imulq	%rdi, %rdx
               	addq	%rax, %rbx
               	cmpq	%rdx, %r8
               	setb	%r12b
               	movzbq	%r12b, %r12
               	movq	%r8, %rax
               	subq	%rdx, %rax
               	movq	%rbx, %rdx
               	negq	%rdx
               	subq	%r12, %rdx
               	cmpq	$0x1, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x1, %rdx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x3, %rax
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %r8
               	xorq	$0x1, %r8
               	negq	%r8
               	movq	%rdi, %rbx
               	andq	%r8, %rbx
               	andq	%r9, %r8
               	cmpq	%rbx, %rax
               	setb	%r12b
               	movzbq	%r12b, %r12
               	subq	%rbx, %rax
               	subq	%r8, %rdx
               	subq	%r12, %rdx
               	leaq	<rip>, %r8       # <addr>
               	movq	(%r8), %r8
               	cmpq	%r8, %rax
               	jne	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movq	(%rdx), %r8
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%eax, %eax
               	cmpq	%r8, %rcx
               	jb	<addr>
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	popq	%rdx
               	movq	%rax, %rbx
               	imulq	%r8, %rbx
               	negq	%rbx
               	addq	%rcx, %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rbx, %rdx
               	movq	%rsi, %rax
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	(%rdx), %rbx
               	xorl	%r13d, %r13d
               	movq	%r8, %r12
               	imulq	%rbx, %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	mulq	%rbx
               	movq	%rdx, %r14
               	popq	%rdx
               	popq	%rax
               	imulq	%r13, %r8
               	imulq	%rbx, %rax
               	addq	%r14, %r8
               	leaq	(%r8,%rax), %rbx
               	movq	(%rdx), %r8
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	%r8, %rcx
               	jb	<addr>
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rsi, %rax
               	divq	%r8
               	imulq	%r8, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	leaq	(%r12,%rdx), %rax
               	cmpq	%r12, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	addq	%rbx, %rdx
               	xorq	%rsi, %rax
               	xorq	%rcx, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%edx, %edx
               	cmpq	%rax, %rcx
               	jb	<addr>
               	movq	%rax, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rbx
               	imulq	%rax, %rbx
               	subq	%rbx, %rcx
               	movq	%rax, %r11
               	pushq	%rdx
               	movq	%rcx, %rdx
               	movq	%rsi, %rax
               	divq	%r11
               	movq	%rax, %rcx
               	popq	%rdx
               	movq	%r8, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %rsi # imm = 0x8000000000000001
               	movq	%r8, %rdx
               	shrq	%rdx
               	movq	%rcx, %rax
               	shrq	%rax
               	movq	%r8, %rbx
               	shlq	$0x3f, %rbx
               	orq	%rbx, %rax
               	divq	%rsi
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rsi, %rax
               	imulq	%rdi, %rax
               	addq	%rsi, %rdx
               	cmpq	%rax, %rcx
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rax
               	addq	%rcx, %rax
               	movq	%r8, %rcx
               	subq	%rdx, %rcx
               	subq	%rsi, %rcx
               	cmpq	$0x1, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x3, %rax
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rsi
               	orq	%rsi, %rdx
               	xorq	$0x1, %rdx
               	negq	%rdx
               	movq	%rdi, %rsi
               	andq	%rdx, %rsi
               	andq	%r9, %rdx
               	cmpq	%rsi, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rsi, %rax
               	subq	%rdx, %rcx
               	movq	%rcx, %rdx
               	subq	%rdi, %rdx
               	movabsq	$-0x4292c96669d3a3d8, %r11 # imm = 0xBD6D3699962C5C28
               	cmpq	%r11, %rax
               	jne	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xf, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rsi # imm = 0xAAAAAAAAAAAAAAAB
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	movq	%rax, %rsi
               	shrq	%rsi
               	imulq	%rdi, %rsi
               	movq	%rcx, %rax
               	subq	%rsi, %rax
               	jmp	<addr>
               	movq	%rdx, %r8
               	jmp	<addr>
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %rcx
               	xorl	%r8d, %r8d
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	jmp	<addr>
               	movq	%rcx, %rbx
               	jmp	<addr>
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	xorl	%ebx, %ebx
               	movq	%rbx, %rax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %r8 # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rsi, %rax
               	mulq	%r8
               	movq	%rdx, %rbx
               	shrq	%rbx
               	movq	%rbx, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %r8 # imm = 0xAAAAAAAAAAAAAAAB
               	pushq	%rdx
               	movq	%rsi, %rax
               	mulq	%r8
               	movq	%rdx, %rax
               	popq	%rdx
               	shrq	%rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movq	%rdi, %rbx
               	movq	%r8, %rdx
               	jmp	<addr>

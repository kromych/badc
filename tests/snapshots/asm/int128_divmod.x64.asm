
int128_divmod.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x18, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	movq	<rip>, %r8 # <addr>
               	orq	%rsi, %r8
               	movq	$-0x1, %rax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	<rip>, %r9 # <addr>
               	cmpq	%r9, %rcx
               	jb	<addr>
               	movq	%rax, -0x18(%rsp)
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %rdx
               	movq	-0x18(%rsp), %rax
               	movq	%rdx, %rbx
               	imulq	%r9, %rbx
               	negq	%rbx
               	addq	%rcx, %rbx
               	movq	%rax, -0x18(%rsp)
               	movq	%rdx, -0x20(%rsp)
               	movq	%rbx, %rdx
               	divq	%r9
               	movq	%rax, %r9
               	movq	-0x20(%rsp), %rdx
               	movq	-0x18(%rsp), %rax
               	movabsq	$-0x3333333333333334, %r11 # imm = 0xCCCCCCCCCCCCCCCC
               	cmpq	%r11, %r9
               	jne	<addr>
               	movabsq	$0xccccccccccccccc, %r11 # imm = 0xCCCCCCCCCCCCCCC
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x1, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rsi, %rcx
               	jb	<addr>
               	movq	%rax, -0x18(%rsp)
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rcx
               	movq	-0x18(%rsp), %rax
               	movq	%rax, -0x18(%rsp)
               	movq	%rcx, %rdx
               	divq	%rsi
               	movq	%rax, %rcx
               	movq	-0x18(%rsp), %rax
               	imulq	%rsi, %rcx
               	subq	%rcx, %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3, %ecx
               	movl	$0x1, %ebx
               	movq	%rdi, %r9
               	orq	%rbx, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %rsi # imm = 0x8000000000000001
               	movq	%rdi, %rdx
               	shrq	%rdx
               	movq	%r8, %rax
               	shrq	%rax
               	movq	%rdi, %r12
               	shlq	$0x3f, %r12
               	orq	%r12, %rax
               	divq	%rsi
               	movq	%rax, %rsi
               	testq	%rsi, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	subq	%rax, %rsi
               	movq	%rsi, %rax
               	mulq	%rcx
               	movq	%rsi, %rax
               	imulq	%rcx, %rax
               	addq	%rsi, %rdx
               	cmpq	%rax, %r8
               	setb	%r12b
               	movzbq	%r12b, %r12
               	movq	%r8, %r10
               	subq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rdi, %rax
               	subq	%rdx, %rax
               	subq	%r12, %rax
               	cmpq	$0x1, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	0x18(%rsp), %r12
               	cmpq	$0x3, %r12
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rax
               	orq	%rax, %rdx
               	xorq	$0x1, %rdx
               	addq	%rsi, %rdx
               	movabsq	$-0x7766554433221103, %r11 # imm = 0x8899AABBCCDDEEFD
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	testq	%r9, %r9
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %rsi # imm = 0x8000000000000001
               	movq	%rdi, %rdx
               	shrq	%rdx
               	movq	%r8, %rax
               	shrq	%rax
               	movq	%rdi, %r9
               	shlq	$0x3f, %r9
               	orq	%r9, %rax
               	divq	%rsi
               	movq	%rax, %rsi
               	testq	%rsi, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	subq	%rax, %rsi
               	movq	%rsi, %rax
               	mulq	%rcx
               	movq	%rsi, %rax
               	imulq	%rcx, %rax
               	addq	%rsi, %rdx
               	cmpq	%rax, %r8
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%r8, %rsi
               	subq	%rax, %rsi
               	movq	%rdi, %rax
               	subq	%rdx, %rax
               	subq	%r9, %rax
               	cmpq	$0x1, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x3, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rdx
               	orq	%rdx, %r9
               	xorq	$0x1, %r9
               	movq	%r9, %rdx
               	negq	%rdx
               	movq	%rcx, %r9
               	andq	%rdx, %r9
               	andq	%rbx, %rdx
               	cmpq	%r9, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	subq	%r9, %rsi
               	subq	%rdx, %rax
               	subq	%r12, %rax
               	movabsq	$0x664421ffddbb9980, %r11 # imm = 0x664421FFDDBB9980
               	movq	%rsi, %rdx
               	cmpq	%r11, %rsi
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %r9 # <addr>
               	movabsq	$-0x7fffffffffffffff, %rsi # imm = 0x8000000000000001
               	xorl	%edx, %edx
               	movq	%r9, %rax
               	shrq	%rax
               	divq	%rsi
               	movq	%rax, %rsi
               	testq	%rsi, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	subq	%rax, %rsi
               	movq	%rsi, %rax
               	mulq	%rcx
               	movq	%rsi, %rax
               	imulq	%rcx, %rax
               	addq	%rsi, %rdx
               	cmpq	%rax, %r9
               	setb	%r12b
               	movzbq	%r12b, %r12
               	subq	%rax, %r9
               	movq	%rdx, %rax
               	negq	%rax
               	subq	%r12, %rax
               	cmpq	$0x1, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x3, %r9
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rax
               	orq	%rax, %rdx
               	xorq	$0x1, %rdx
               	leaq	(%rsi,%rdx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x7fffffffffffffff, %r9 # imm = 0x8000000000000001
               	xorl	%edx, %edx
               	movq	%rsi, %rax
               	shrq	%rax
               	divq	%r9
               	movq	%rax, %r9
               	testq	%r9, %r9
               	setne	%al
               	movzbq	%al, %rax
               	subq	%rax, %r9
               	movq	%r9, %rax
               	mulq	%rcx
               	movq	%r9, %rax
               	imulq	%rcx, %rax
               	addq	%r9, %rdx
               	cmpq	%rax, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	%rax, %rsi
               	movq	%rdx, %rax
               	negq	%rax
               	subq	%r9, %rax
               	cmpq	$0x1, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %rax
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x3, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %r9
               	orq	%r9, %rdx
               	xorq	$0x1, %rdx
               	negq	%rdx
               	movq	%rcx, %r9
               	andq	%rdx, %r9
               	andq	%rbx, %rdx
               	cmpq	%r9, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	subq	%r9, %rsi
               	subq	%rdx, %rax
               	subq	%r12, %rax
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %r9 # <addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%esi, %esi
               	cmpq	%r9, %rdi
               	jb	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %rsi
               	movq	%rsi, %rax
               	imulq	%r9, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movq	%r8, %rax
               	divq	%r9
               	movq	<rip>, %r9 # <addr>
               	movq	%rax, %r12
               	imulq	%r9, %r12
               	mulq	%r9
               	imulq	%r9, %rsi
               	leaq	(%rdx,%rsi), %r9
               	movq	<rip>, %rsi # <addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpq	%rsi, %rdi
               	jb	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%r8, %rax
               	divq	%rsi
               	imulq	%rsi, %rax
               	movq	%r8, %rdx
               	subq	%rax, %rdx
               	leaq	(%r12,%rdx), %rax
               	cmpq	%r12, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	addq	%r9, %rdx
               	xorq	%r8, %rax
               	xorq	%rdi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rsi # <addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	cmpq	%rsi, %rdi
               	jb	<addr>
               	movq	%rax, -0x18(%rsp)
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %r9
               	movq	-0x18(%rsp), %rax
               	movq	%r9, %rdx
               	imulq	%rsi, %rdx
               	subq	%rdx, %rdi
               	movq	%rax, -0x18(%rsp)
               	movq	%rdi, %rdx
               	movq	%r8, %rax
               	divq	%rsi
               	movq	%rax, %rsi
               	movq	-0x18(%rsp), %rax
               	movq	%r9, %rdx
               	orq	%rbx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %rdi # imm = 0x8000000000000001
               	movq	%r9, %rdx
               	shrq	%rdx
               	movq	%rsi, %rax
               	shrq	%rax
               	movq	%r9, %r8
               	shlq	$0x3f, %r8
               	orq	%r8, %rax
               	divq	%rdi
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	setne	%al
               	movzbq	%al, %rax
               	subq	%rax, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	movq	%rdi, %rax
               	imulq	%rcx, %rax
               	addq	%rdi, %rdx
               	cmpq	%rax, %rsi
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rax, %rsi
               	subq	%rdx, %r9
               	subq	%rdi, %r9
               	cmpq	$0x1, %r9
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	$0x1, %r9
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x3, %rsi
               	setb	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rdx
               	orq	%rdx, %rax
               	xorq	$0x1, %rax
               	negq	%rax
               	andq	%rax, %rcx
               	andq	%rbx, %rax
               	cmpq	%rcx, %rsi
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	%rcx, %rsi
               	subq	%rax, %r9
               	movq	%r9, %rax
               	subq	%rdx, %rax
               	movabsq	$-0x4292c96669d3a3d8, %r11 # imm = 0xBD6D3699962C5C28
               	movq	%rsi, %rcx
               	cmpq	%r11, %rsi
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rdi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rax, -0x18(%rsp)
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	-0x18(%rsp), %rax
               	shrq	%rdx
               	imulq	%rcx, %rdx
               	subq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rax, %r9
               	jmp	<addr>
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %rsi
               	xorl	%r9d, %r9d
               	jmp	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	jmp	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	xorl	%edx, %edx
               	movq	%rdx, %rsi
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rsi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%r8, %rax
               	mulq	%rsi
               	shrq	%rdx
               	imulq	%rcx, %rdx
               	movq	%r8, %rsi
               	subq	%rdx, %rsi
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rsi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%r8, %rax
               	mulq	%rsi
               	shrq	%rdx
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movq	%rcx, %rbx
               	movq	%rsi, %rdx
               	jmp	<addr>

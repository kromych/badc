
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
               	subq	$0x28, %rsp
               	movq	<rip>, %rsi # <addr>
               	xorl	%edi, %edi
               	movq	<rip>, %r8 # <addr>
               	orq	%rdi, %r8
               	movq	$-0x1, %r10
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	<rip>, %r9 # <addr>
               	cmpq	%r9, %rcx
               	jb	<addr>
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r11
               	movq	%r11, %rax
               	imulq	%r9, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movq	%r10, %rax
               	divq	%r9
               	movq	%r10, 0x8(%rsp)
               	movabsq	$-0x3333333333333334, %r10 # imm = 0xCCCCCCCCCCCCCCCC
               	cmpq	%r10, %rax
               	movq	0x8(%rsp), %r10
               	jne	<addr>
               	movq	%r10, 0x8(%rsp)
               	movabsq	$0xccccccccccccccc, %r10 # imm = 0xCCCCCCCCCCCCCCC
               	movq	%r11, %rax
               	cmpq	%r10, %r11
               	movq	0x8(%rsp), %r10
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x28, %rsp
               	retq
               	movq	<rip>, %r9 # <addr>
               	cmpq	%r9, %rcx
               	jb	<addr>
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rdx, %rcx
               	movq	%rcx, %rdx
               	movq	%r10, %rax
               	divq	%r9
               	imulq	%r9, %rax
               	movq	%r10, %rcx
               	subq	%rax, %rcx
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rdi, %rax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x3, %ecx
               	movl	$0x1, %r9d
               	movq	%rsi, %r10
               	orq	%r9, %r10
               	testq	%r10, %r10
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %rdi # imm = 0x8000000000000001
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%r8, %rax
               	shrq	%rax
               	movq	%rsi, %r11
               	shlq	$0x3f, %r11
               	orq	%r11, %rax
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
               	cmpq	%rax, %r8
               	setb	%r11b
               	movzbq	%r11b, %r11
               	movq	%r10, 0x10(%rsp)
               	movq	%r8, %r10
               	subq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	subq	%r11, %rax
               	cmpq	$0x1, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	0x18(%rsp), %r11
               	cmpq	$0x3, %r11
               	setb	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	orq	%rax, %rdx
               	xorq	$0x1, %rdx
               	addq	%rdi, %rdx
               	movq	0x10(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movabsq	$-0x7766554433221103, %r10 # imm = 0x8899AABBCCDDEEFD
               	movq	%rdx, %rax
               	cmpq	%r10, %rdx
               	movq	0x8(%rsp), %r10
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x28, %rsp
               	retq
               	testq	%r10, %r10
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %rdi # imm = 0x8000000000000001
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%r8, %rax
               	shrq	%rax
               	movq	%rsi, %r10
               	shlq	$0x3f, %r10
               	orq	%r10, %rax
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
               	cmpq	%rax, %r8
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r8, %rdi
               	subq	%rax, %rdi
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	subq	%r10, %rax
               	cmpq	$0x1, %rax
               	setb	%r10b
               	movzbq	%r10b, %r10
               	cmpq	$0x1, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x3, %rdi
               	setb	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rdx
               	orq	%rdx, %r10
               	xorq	$0x1, %r10
               	movq	%r10, %rdx
               	negq	%rdx
               	movq	%rcx, %r10
               	andq	%rdx, %r10
               	andq	%r9, %rdx
               	cmpq	%r10, %rdi
               	setb	%r11b
               	movzbq	%r11b, %r11
               	subq	%r10, %rdi
               	subq	%rdx, %rax
               	subq	%r11, %rax
               	movabsq	$0x664421ffddbb9980, %r11 # imm = 0x664421FFDDBB9980
               	movq	%rdi, %rdx
               	cmpq	%r11, %rdi
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x28, %rsp
               	retq
               	movq	<rip>, %r11 # <addr>
               	movabsq	$-0x7fffffffffffffff, %rdi # imm = 0x8000000000000001
               	xorl	%r10d, %r10d
               	movq	%r11, %rax
               	shrq	%rax
               	movq	%r10, %rdx
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
               	movq	%r10, 0x10(%rsp)
               	cmpq	%rax, %r11
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x18(%rsp)
               	subq	%rax, %r11
               	movq	%rdx, %rax
               	negq	%rax
               	subq	0x18(%rsp), %rax
               	cmpq	$0x1, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x3, %r11
               	setb	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	orq	%rax, %rdx
               	xorq	$0x1, %rdx
               	leaq	(%rdi,%rdx), %rax
               	movq	0x10(%rsp), %r10
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%r10, %r10
               	je	<addr>
               	movq	%r10, %rax
               	addq	$0x28, %rsp
               	retq
               	movq	<rip>, %rdi # <addr>
               	movabsq	$-0x7fffffffffffffff, %r10 # imm = 0x8000000000000001
               	xorl	%edx, %edx
               	movq	%rdi, %rax
               	shrq	%rax
               	divq	%r10
               	movq	%rax, %r10
               	testq	%r10, %r10
               	setne	%al
               	movzbq	%al, %rax
               	subq	%rax, %r10
               	movq	%r10, %rax
               	mulq	%rcx
               	movq	%r10, %rax
               	imulq	%rcx, %rax
               	addq	%r10, %rdx
               	cmpq	%rax, %rdi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	subq	%rax, %rdi
               	movq	%rdx, %rax
               	negq	%rax
               	subq	%r10, %rax
               	cmpq	$0x1, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	cmpq	$0x3, %rdi
               	setb	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r10
               	orq	%r10, %rdx
               	xorq	$0x1, %rdx
               	negq	%rdx
               	movq	%rcx, %r10
               	andq	%rdx, %r10
               	andq	%r9, %rdx
               	cmpq	%r10, %rdi
               	setb	%r11b
               	movzbq	%r11b, %r11
               	subq	%r10, %rdi
               	subq	%rdx, %rax
               	subq	%r11, %rax
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x28, %rsp
               	retq
               	movq	<rip>, %r10 # <addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	xorl	%edi, %edi
               	cmpq	%r10, %rsi
               	jb	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %rdi
               	movq	%rdi, %rax
               	imulq	%r10, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movq	%r8, %rax
               	divq	%r10
               	movq	<rip>, %r10 # <addr>
               	movq	%rax, %r11
               	imulq	%r10, %r11
               	mulq	%r10
               	imulq	%r10, %rdi
               	leaq	(%rdx,%rdi), %r10
               	movq	<rip>, %rdi # <addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	cmpq	%rdi, %rsi
               	jb	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%r8, %rax
               	divq	%rdi
               	imulq	%rdi, %rax
               	movq	%r8, %rdx
               	subq	%rax, %rdx
               	leaq	(%r11,%rdx), %rax
               	cmpq	%r11, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	addq	%r10, %rdx
               	xorq	%r8, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	<rip>, %r10 # <addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	xorl	%r11d, %r11d
               	cmpq	%r10, %rsi
               	jb	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %rdi
               	movq	%rdi, %rax
               	imulq	%r10, %rax
               	subq	%rax, %rsi
               	movq	%rsi, %rdx
               	movq	%r8, %rax
               	divq	%r10
               	movq	%rax, %rsi
               	movq	%rdi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %r8 # imm = 0x8000000000000001
               	movq	%rdi, %rdx
               	shrq	%rdx
               	movq	%rsi, %rax
               	shrq	%rax
               	movq	%rdi, %r10
               	shlq	$0x3f, %r10
               	orq	%r10, %rax
               	divq	%r8
               	movq	%rax, %r8
               	testq	%r8, %r8
               	setne	%al
               	movzbq	%al, %rax
               	subq	%rax, %r8
               	movq	%r8, %rax
               	mulq	%rcx
               	movq	%r8, %rax
               	imulq	%rcx, %rax
               	addq	%r8, %rdx
               	cmpq	%rax, %rsi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rax, %rsi
               	subq	%rdx, %rdi
               	subq	%r8, %rdi
               	cmpq	$0x1, %rdi
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	$0x1, %rdi
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x3, %rsi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdx
               	orq	%rdx, %rax
               	xorq	$0x1, %rax
               	negq	%rax
               	andq	%rax, %rcx
               	andq	%r9, %rax
               	cmpq	%rcx, %rsi
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	%rcx, %rsi
               	subq	%rax, %rdi
               	movq	%rdi, %r11
               	subq	%rdx, %r11
               	movabsq	$-0x4292c96669d3a3d8, %r9 # imm = 0xBD6D3699962C5C28
               	movq	%rsi, %rax
               	cmpq	%r9, %rsi
               	jne	<addr>
               	testq	%r11, %r11
               	je	<addr>
               	movl	$0xf, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rdi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rsi, %rax
               	mulq	%rdi
               	shrq	%rdx
               	imulq	%rcx, %rdx
               	subq	%rdx, %rsi
               	jmp	<addr>
               	movq	%r11, %rdi
               	jmp	<addr>
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %rsi
               	xorl	%edi, %edi
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	xorl	%edx, %edx
               	movq	%rdx, %rdi
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x5, %r10d
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rdi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%r8, %rax
               	mulq	%rdi
               	shrq	%rdx
               	imulq	%rcx, %rdx
               	movq	%r8, %rdi
               	subq	%rdx, %rdi
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rdi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%r8, %rax
               	mulq	%rdi
               	shrq	%rdx
               	jmp	<addr>
               	movl	$0x2, %edi
               	jmp	<addr>
               	movq	%rdi, %rax
               	jmp	<addr>
               	movq	%rcx, %rdx
               	movq	%rdi, %r11
               	jmp	<addr>

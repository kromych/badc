
int128_overflow_builtin.x64:	file format elf64-x86-64

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
               	subq	$0x180, %rsp            # imm = 0x180
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	-0x118(%rbp), %rax
               	movl	$0x7b, %ecx
               	movl	%ecx, (%rax)
               	movl	-0x118(%rbp), %eax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	movl	$0x38, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	leaq	-0x118(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	leaq	-0x118(%rbp), %rax
               	movabsq	$-0x2, %rcx
               	movl	%ecx, (%rax)
               	movslq	-0x118(%rbp), %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x3e, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	leaq	-0x118(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	leaq	-0x118(%rbp), %rax
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%rax)
               	movq	-0x118(%rbp), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x44, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	leaq	-0x128(%rbp), %rax
               	movabsq	$-0xf, %rcx
               	movq	%rcx, (%rax)
               	movq	-0x128(%rbp), %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	cmpq	$-0xf, %rax
               	je	<addr>
               	movl	$0x47, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	leaq	-0x128(%rbp), %rax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, (%rax)
               	movq	-0x128(%rbp), %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4a, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	movl	$0x4b, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	movl	$0x48, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	movl	$0x3f, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>

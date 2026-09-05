
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
               	subq	$0x190, %rsp            # imm = 0x190
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	leaq	-0xe8(%rbp), %rcx
               	movl	$0x7b, %edx
               	movl	%edx, (%rcx)
               	movl	-0xe8(%rbp), %edx
               	cmpl	$0x7b, %edx
               	je	<addr>
               	movl	$0x38, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	leave
               	retq
               	xorq	%rax, %rax
               	movl	%eax, (%rcx)
               	movq	%rax, %rsi
               	movabsq	$-0x2, %rdx
               	movl	%edx, (%rcx)
               	movslq	-0xe8(%rbp), %rdx
               	movq	%rdx, %rdi
               	sarq	$0x3f, %rdi
               	cmpl	$-0x2, %edx
               	je	<addr>
               	movl	$0x3e, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	%edx, %rax
               	leave
               	retq
               	movl	%eax, (%rcx)
               	leaq	-0xe8(%rbp), %rax
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%rax)
               	movq	-0xe8(%rbp), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x44, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	-0xf8(%rbp), %rcx
               	movabsq	$-0xf, %rax
               	movq	%rax, (%rcx)
               	movq	-0xf8(%rbp), %rax
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	cmpq	$-0xf, %rax
               	je	<addr>
               	movl	$0x47, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, (%rcx)
               	movq	-0xf8(%rbp), %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4a, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	xorq	%rax, %rax
               	leave
               	retq
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	movl	$0x4b, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	cmpq	$-0x1, %rsi
               	je	<addr>
               	movl	$0x48, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	cmpq	$-0x1, %rdi
               	je	<addr>
               	movl	$0x3f, %edx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	jmp	<addr>

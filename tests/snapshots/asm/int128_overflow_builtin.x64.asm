
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
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x7b, (%rdx)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x7b, %eax
               	je	<addr>
               	movl	$0x38, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	%eax, (%rdx)
               	movl	$0xfffffffe, (%rdx)     # imm = 0xFFFFFFFE
               	movslq	-0x8(%rbp), %rcx
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	cmpl	$-0x2, %ecx
               	je	<addr>
               	movl	$0x3e, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	%eax, (%rdx)
               	movq	$-0x1, (%rdx)
               	movq	-0x8(%rbp), %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x44, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	-0x8(%rbp), %rcx
               	movq	$-0xf, (%rcx)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	cmpq	$-0xf, %rax
               	je	<addr>
               	movl	$0x47, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, (%rcx)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4a, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x4b, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	cmpl	$-0x1, %edx
               	je	<addr>
               	movl	$0x48, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	cmpl	$-0x1, %esi
               	je	<addr>
               	movl	$0x3f, %ecx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>

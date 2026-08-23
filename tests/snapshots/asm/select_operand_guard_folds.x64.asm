
select_operand_guard_folds.x64:	file format elf64-x86-64

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

<add_page>:
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	orq	%rdi, %rax
               	movq	%rax, (%rcx)
               	andq	$0x3, %rax
               	movslq	%eax, %rax
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>

<main>:
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movq	(%rdx), %rdx
               	andq	$0x400000, %rdx         # imm = 0x400000
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x4, %edx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movq	(%rdx), %rdx
               	andq	$0x400000, %rdx         # imm = 0x400000
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x4, %edx
               	orq	$0x100173, %rdx         # imm = 0x100173
               	cmpq	$0x100173, %rdx         # imm = 0x100173
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x400000, %edx         # imm = 0x400000
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rcx), %rcx
               	andq	$0x400000, %rcx         # imm = 0x400000
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %ecx
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rcx), %rcx
               	andq	$0x400000, %rcx         # imm = 0x400000
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	$0x100173, %rax         # imm = 0x100173
               	cmpq	$0x100177, %rax         # imm = 0x100177
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	orq	$0x1000, %rax           # imm = 0x1000
               	movq	%rax, (%rdx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	andq	$0x3, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rdx
               	movl	$0x1, %eax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rax, %rcx
               	orq	$0x1000, %rcx           # imm = 0x1000
               	movq	%rcx, (%rdx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	andq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x1001, %rcx           # imm = 0x1001
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>

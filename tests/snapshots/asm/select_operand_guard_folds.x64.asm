
select_operand_guard_folds.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	andq	$0x400000, %rax         # imm = 0x400000
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	andq	$0x400000, %rax         # imm = 0x400000
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	orq	$0x100173, %rax         # imm = 0x100173
               	cmpq	$0x100173, %rax         # imm = 0x100173
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x400000, %eax         # imm = 0x400000
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	andq	$0x400000, %rax         # imm = 0x400000
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	andq	$0x400000, %rax         # imm = 0x400000
               	testq	%rax, %rax
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
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	orq	$0x1000, %rax           # imm = 0x1000
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	andq	$0x3, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	orq	$0x1000, %rax           # imm = 0x1000
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	andq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1001, %rax           # imm = 0x1001
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
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
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>

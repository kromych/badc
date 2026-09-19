
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
               	xorl	%eax, %eax
               	jmp	<addr>

<main>:
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movq	%rax, (%rdx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rsi
               	movq	(%rsi), %rsi
               	andq	$0x400000, %rsi         # imm = 0x400000
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x4, %esi
               	movq	(%rcx), %rsi
               	movq	(%rsi), %rsi
               	andq	$0x400000, %rsi         # imm = 0x400000
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x4, %esi
               	orq	$0x100173, %rsi         # imm = 0x100173
               	cmpq	$0x100173, %rsi         # imm = 0x100173
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x400000, %esi         # imm = 0x400000
               	movq	%rsi, (%rdx)
               	movq	(%rcx), %rdx
               	movq	(%rdx), %rdx
               	andq	$0x400000, %rdx         # imm = 0x400000
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x4, %edx
               	movq	(%rcx), %rcx
               	movq	(%rcx), %rcx
               	andq	$0x400000, %rcx         # imm = 0x400000
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %ecx
               	orq	$0x100173, %rcx         # imm = 0x100173
               	cmpq	$0x100177, %rcx         # imm = 0x100177
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	%eax, (%rcx)
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
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0x1, %eax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %rcx
               	orq	$0x1000, %rcx           # imm = 0x1000
               	movq	%rcx, (%rdx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	andq	$0x3, %rcx
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
               	movq	%rax, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx
               	xorl	%edx, %edx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %rcx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movq	%rdx, %rax
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>

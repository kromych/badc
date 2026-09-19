
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
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	orq	%rdi, %rax
               	movq	%rax, (%rcx)
               	andq	$0x3, %rax
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
               	testl	$0x400000, %esi         # imm = 0x400000
               	je	<addr>
               	movl	$0x4, %esi
               	movq	(%rcx), %rsi
               	movq	(%rsi), %rsi
               	testl	$0x400000, %esi         # imm = 0x400000
               	je	<addr>
               	movl	$0x4, %esi
               	orq	$0x100173, %rsi         # imm = 0x100173
               	cmpl	$0x100173, %esi         # imm = 0x100173
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	$0x400000, (%rdx)       # imm = 0x400000
               	movq	(%rcx), %rdx
               	movq	(%rdx), %rdx
               	testl	$0x400000, %edx         # imm = 0x400000
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rcx), %rax
               	movq	(%rax), %rax
               	testl	$0x400000, %eax         # imm = 0x400000
               	je	<addr>
               	movl	$0x4, %eax
               	orq	$0x100173, %rax         # imm = 0x100173
               	cmpl	$0x100177, %eax         # imm = 0x100177
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rcx
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	orq	$0x1000, %rax           # imm = 0x1000
               	movq	%rax, (%rcx)
               	testb	$0x3, %al
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x1, %eax
               	movl	%eax, (%rdx)
               	testl	%eax, %eax
               	je	<addr>
               	movq	%rax, %rdx
               	orq	$0x1000, %rdx           # imm = 0x1000
               	movq	%rdx, (%rcx)
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
               	leaq	<rip>, %rdx
               	movl	%eax, (%rdx)
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movq	%rax, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	cmpl	$0x0, (%rdx)
               	je	<addr>
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	$0x0, (%rdx)
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x1, %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>

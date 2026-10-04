
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
               	leaq	<rip>, %rcx      # <addr>
               	leaq	<rip>, %rax      # <addr>
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
               	leaq	<rip>, %rdx      # <addr>
               	xorl	%eax, %eax
               	movq	%rax, (%rdx)
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rsi
               	movq	(%rsi), %rsi
               	testl	$0x400000, %esi         # imm = 0x400000
               	movq	(%rcx), %rsi
               	movq	(%rsi), %rsi
               	testl	$0x400000, %esi         # imm = 0x400000
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	$0x400000, (%rdx)       # imm = 0x400000
               	movq	(%rcx), %rdx
               	movq	(%rdx), %rdx
               	testl	$0x400000, %edx         # imm = 0x400000
               	movq	(%rcx), %rcx
               	movq	(%rcx), %rcx
               	testl	$0x400000, %ecx         # imm = 0x400000
               	je	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx      # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %ecx
               	orq	$0x1000, %rcx           # imm = 0x1000
               	movq	%rcx, (%rdx)
               	testb	$0x3, %cl
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movl	$0x1, %ecx
               	movl	%ecx, (%rdx)
               	leaq	<rip>, %rdx      # <addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movq	%rcx, %rax
               	orq	$0x1000, %rax           # imm = 0x1000
               	movq	%rax, (%rdx)
               	andq	$0x3, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	(%rdx), %rax
               	cmpq	$0x1001, %rax           # imm = 0x1001
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movl	%ecx, (%rdx)
               	testl	%ecx, %ecx
               	je	<addr>
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	cmpl	$0x0, (%rdx)
               	je	<addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	%ecx, (%rdx)
               	testl	%ecx, %ecx
               	je	<addr>
               	cmpl	$0x0, (%rax)
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movl	$0x6, %eax
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0x2, %eax
               	retq

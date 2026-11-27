
store_bounds_readback.x64:	file format elf64-x86-64

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

<touch_int>:
               	retq

<touch_box>:
               	retq

<write_int>:
               	movl	%esi, (%rdi)
               	retq

<volatile_object>:
               	subq	$0x18, %rsp
               	movl	$0x3, 0x8(%rsp)
               	movl	<rip>, %eax # <addr>
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	movl	%eax, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	testl	%eax, %eax
               	setge	%cl
               	movzbq	%cl, %rcx
               	movl	0x8(%rsp), %eax
               	cmpl	$0x1ff, %eax            # imm = 0x1FF
               	setle	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x30, %rsp
               	pushq	%rbx
               	leaq	0x20(%rsp), %rdi
               	callq	<addr>
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	movl	%eax, 0x18(%rsp)
               	movl	<rip>, %eax # <addr>
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	movsbq	%al, %rax
               	testl	%eax, %eax
               	setl	%cl
               	movzbq	%cl, %rcx
               	cmpl	$-0x38, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	movl	$0x2, %ecx
               	xorl	%edx, %edx
               	cmpl	$0x3, %eax
               	cmoveq	%rdx, %rcx
               	movl	<rip>, %eax # <addr>
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	andq	$0xff, %rax
               	cmpl	$0xc8, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	incq	%rax
               	movq	%rcx, %rdx
               	orq	$0x4, %rdx
               	cmpl	$0x3, %eax
               	cmovneq	%rdx, %rcx
               	movl	<rip>, %eax # <addr>
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	imulq	$0xc8, %rax, %rax
               	movswq	%ax, %rax
               	testl	%eax, %eax
               	setl	%dl
               	movzbq	%dl, %rdx
               	cmpl	$0xffff9c40, %eax       # imm = 0xFFFF9C40
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rdx, %rax
               	movq	%rcx, %rdx
               	orq	$0x8, %rdx
               	cmpl	$0x3, %eax
               	cmovneq	%rdx, %rcx
               	movl	<rip>, %eax # <addr>
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	andq	$0x7, %rax
               	xorq	$-0x1, %rax
               	cmpl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	seta	%dl
               	movzbq	%dl, %rdx
               	cmpl	$-0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rdx, %rax
               	movq	%rcx, %rbx
               	orq	$0x10, %rbx
               	cmpl	$0x3, %eax
               	cmoveq	%rcx, %rbx
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	movl	%eax, 0x18(%rsp)
               	leaq	0x18(%rsp), %rdi
               	movq	$-0x7, %rsi
               	callq	<addr>
               	movl	0x18(%rsp), %eax
               	testl	%eax, %eax
               	setl	%cl
               	movzbq	%cl, %rcx
               	cmpl	$-0x7, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	movq	%rbx, %rcx
               	orq	$0x20, %rcx
               	cmpl	$0x3, %eax
               	cmovneq	%rcx, %rbx
               	leaq	0x18(%rsp), %rdi
               	movq	%rdi, <rip> # <addr>
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	movl	%eax, 0x18(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movq	$-0x3, %rsi
               	callq	<addr>
               	movl	0x18(%rsp), %eax
               	testl	%eax, %eax
               	setl	%cl
               	movzbq	%cl, %rcx
               	cmpl	$-0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	movq	%rbx, %rcx
               	orq	$0x40, %rcx
               	cmpl	$0x3, %eax
               	cmovneq	%rcx, %rbx
               	callq	<addr>
               	movq	%rbx, %rcx
               	orq	$0x80, %rcx
               	cmpl	$0x3, %eax
               	cmoveq	%rbx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq

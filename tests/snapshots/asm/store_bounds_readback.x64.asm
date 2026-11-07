
store_bounds_readback.x64:	file format elf64-x86-64

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

<touch_int>:
               	retq

<touch_box>:
               	retq

<write_int>:
               	movl	%esi, (%rdi)
               	retq

<volatile_object>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x3, -0x8(%rbp)
               	movl	<rip>, %eax # <addr>
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	testl	%eax, %eax
               	setge	%al
               	movzbq	%al, %rax
               	movl	-0x8(%rbp), %ecx
               	cmpl	$0x1ff, %ecx            # imm = 0x1FF
               	setle	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	movl	%eax, -0x18(%rbp)
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
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %ebx
               	movl	<rip>, %eax # <addr>
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	andq	$0xff, %rax
               	cmpl	$0xc8, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	incq	%rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	orq	$0x4, %rbx
               	movl	<rip>, %eax # <addr>
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	imulq	$0xc8, %rax, %rax
               	movswq	%ax, %rax
               	testl	%eax, %eax
               	setl	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0xffff9c40, %eax       # imm = 0xFFFF9C40
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	orq	$0x8, %rbx
               	movl	<rip>, %eax # <addr>
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	andq	$0x7, %rax
               	xorq	$-0x1, %rax
               	cmpl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	seta	%cl
               	movzbq	%cl, %rcx
               	cmpl	$-0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	orq	$0x10, %rbx
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rdi
               	movq	$-0x7, %rsi
               	callq	<addr>
               	movl	-0x18(%rbp), %eax
               	testl	%eax, %eax
               	setl	%cl
               	movzbq	%cl, %rcx
               	cmpl	$-0x7, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	orq	$0x20, %rbx
               	leaq	-0x18(%rbp), %rdi
               	movq	%rdi, <rip> # <addr>
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	movl	%eax, -0x18(%rbp)
               	movq	<rip>, %rdi # <addr>
               	movq	$-0x3, %rsi
               	callq	<addr>
               	movl	-0x18(%rbp), %eax
               	testl	%eax, %eax
               	setl	%cl
               	movzbq	%cl, %rcx
               	cmpl	$-0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	orq	$0x40, %rbx
               	callq	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	orq	$0x80, %rbx
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	xorl	%ebx, %ebx
               	jmp	<addr>

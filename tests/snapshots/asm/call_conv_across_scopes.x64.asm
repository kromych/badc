
call_conv_across_scopes.x64:	file format elf64-x86-64

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

<block_first>:
               	pushq	%rax
               	subq	$0x20, %rsp
               	movl	<rip>, %eax # <addr>
               	leaq	0xe(%rax), %rcx
               	callq	<addr>
               	addq	$0x20, %rsp
               	popq	%r11
               	retq

<block_plain>:
               	pushq	%rax
               	subq	$0x20, %rsp
               	movl	$0x2, %ecx
               	callq	<addr>
               	addq	$0x20, %rsp
               	popq	%r11
               	retq

<hidden_by_local>:
               	subq	$0x10, %rsp
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movl	$0x5, %ecx
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rbx, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq

<names_foreign>:
               	pushq	%rax
               	subq	$0x20, %rsp
               	movl	$0x1, %ecx
               	callq	<addr>
               	addq	$0x20, %rsp
               	popq	%r11
               	retq

<keeps_values>:
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %r12 # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	<rip>, %r14 # <addr>
               	movq	<rip>, %r15 # <addr>
               	movq	<rip>, %rbp # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x58(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x50(%rsp)
               	movl	<rip>, %ecx # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	shlq	%r12
               	addq	%r12, %rax
               	leaq	(%r13,%r13,2), %rcx
               	addq	%rcx, %rax
               	shlq	$0x2, %r14
               	addq	%r14, %rax
               	leaq	(%r15,%r15,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %rbp, %rcx
               	addq	%rcx, %rax
               	movq	0x58(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x50(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x18, %rsp
               	retq

<add100>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%rdi
               	pushq	%rsi
               	movq	$-0x1, %rsi
               	movq	$-0x1, %rdi
               	leaq	0x64(%rcx), %rax
               	popq	%rsi
               	popq	%rdi
               	popq	%rbp
               	retq

<twice>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%rdi
               	pushq	%rsi
               	movq	$-0x1, %rsi
               	movq	$-0x1, %rdi
               	movq	%rcx, %rax
               	shlq	%rax
               	popq	%rsi
               	popq	%rdi
               	popq	%rbp
               	retq

<times3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%rdi
               	pushq	%rsi
               	movq	$-0x1, %rsi
               	movq	$-0x1, %rdi
               	leaq	(%rcx,%rcx,2), %rax
               	popq	%rsi
               	popq	%rdi
               	popq	%rbp
               	retq

<fcl>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%rdi
               	pushq	%rsi
               	movq	$-0x1, %rsi
               	movq	$-0x1, %rdi
               	movl	<rip>, %eax # <addr>
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	popq	%rsi
               	popq	%rdi
               	popq	%rbp
               	retq

<cleanup_hidden>:
               	subq	$0x18, %rsp
               	subq	$0x20, %rsp
               	movl	$0x2, 0x28(%rsp)
               	leaq	0x28(%rsp), %rcx
               	callq	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x10, %rsp
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movl	$0xe, %edi
               	callq	<addr>
               	cmpl	$0x79, %eax
               	setne	%bl
               	movzbq	%bl, %rbx
               	callq	<addr>
               	cmpl	$0x66, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	orq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0xa, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	orq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x5, %rax
               	orq	%rax, %rbx
               	callq	<addr>
               	cmpq	$0x247, %rax            # imm = 0x247
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	orq	%rax, %rbx
               	movl	$0x1, %ecx
               	callq	<addr>
               	cmpl	$0x65, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rax, %rbx
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x9, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x6, %rax
               	orq	%rbx, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq

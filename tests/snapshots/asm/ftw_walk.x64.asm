
ftw_walk.x64:	file format elf64-x86-64

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

<visit>:
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x128, %rsp            # imm = 0x128
               	pushq	%rbx
               	leaq	-0x118(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	0x10(%rax), %r10d
               	movl	%r10d, 0x10(%rdi)
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	leaq	-0x118(%rbp), %rcx
               	xorl	%r8d, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	leaq	-0x118(%rbp), %rcx
               	movl	$0x1, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	leaq	-0x118(%rbp), %rcx
               	movl	$0x2, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x118(%rbp), %rdi
               	leaq	-<rip>, %rsi      # <addr>
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	leaq	-0x118(%rbp), %rcx
               	xorl	%r8d, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	leaq	-0x118(%rbp), %rcx
               	movl	$0x1, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	leaq	-0x118(%rbp), %rcx
               	movl	$0x2, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x118(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>

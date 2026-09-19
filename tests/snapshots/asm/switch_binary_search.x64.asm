
switch_binary_search.x64:	file format elf64-x86-64

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

<classify_signed>:
               	cmpl	$0x1, %edi
               	jl	<addr>
               	cmpl	$0x2a, %edi
               	jl	<addr>
               	cmpl	$0x3e8, %edi            # imm = 0x3E8
               	jl	<addr>
               	cmpl	$0x3e8, %edi            # imm = 0x3E8
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x7, %eax
               	retq
               	cmpl	$0x2a, %edi
               	jne	<addr>
               	movl	$0x6, %eax
               	retq
               	cmpl	$0x7, %edi
               	jl	<addr>
               	cmpl	$0x7, %edi
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpl	$-0x3, %edi
               	jl	<addr>
               	testl	%edi, %edi
               	jl	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpl	$-0x3, %edi
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$-0x64, %edi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq

<classify_unsigned>:
               	cmpl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	jb	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%rdi, %rax
               	cmpl	%r11d, %edi
               	jb	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rdi, %rax
               	cmpl	%r11d, %edi
               	jb	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%rdi, %rax
               	cmpl	%r11d, %edi
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x4, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	cmpl	$0x5, %edi
               	jb	<addr>
               	cmpl	$0x5, %edi
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	$-0x64, %rdi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x3, %rdi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, %rdi
               	movq	(%rbx), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3e7, %edi            # imm = 0x3E7
               	movq	(%rbx), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x20, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x21, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x22, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x23, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x24, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x80000001, %edi       # imm = 0x80000001
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x25, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq


divmod_pair_shared_quotient.x64:	file format elf64-x86-64

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

<check_uint>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdx, %r9
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	movq	%rax, %r8
               	cmpl	%r9d, %r8d
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%r8, %rax
               	imulq	%rsi, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	cmpl	%ecx, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	addq	%r8, %rdx
               	addq	%r9, %rcx
               	cmpl	%ecx, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	leaq	(%rdx,%r8), %rax
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	imulq	%r8, %rsi
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	addq	%rsi, %rax
               	cmpl	%edi, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax       # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rax
               	movl	(%rax), %esi
               	movl	0x4(%rax), %r8d
               	movl	0x8(%rax), %r9d
               	movl	0xc(%rax), %eax
               	pushq	%rax
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	movq	%rax, %rdi
               	popq	%rax
               	cmpl	%r9d, %edi
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	%rdi, %rdx
               	imulq	%r8, %rdx
               	negq	%rdx
               	addq	%rsi, %rdx
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	addq	%rdi, %rdx
               	addq	%rax, %r9
               	cmpl	%r9d, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	imulq	%rdi, %r8
               	movq	%rsi, %rax
               	subq	%r8, %rax
               	addq	%rdi, %rax
               	cmpl	%r9d, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movq	%rsi, %rax
               	subq	%r8, %rax
               	addq	%r8, %rax
               	cmpl	%esi, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	incq	%rcx
               	cmpl	$0xc, %ecx
               	jb	<addr>
               	movl	$0x11, %edi
               	movl	$0x5, %esi
               	movl	$0x3, %edx
               	movl	$0x2, %ecx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x1e, %rax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movl	$0x7, %esi
               	movl	$0x24924924, %edx       # imm = 0x24924924
               	movl	$0x3, %ecx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movl	$0xfffffffe, %esi       # imm = 0xFFFFFFFE
               	movl	$0x1, %edx
               	movq	%rdx, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	movl	$0x3, %esi
               	movq	%rdi, %rdx
               	movq	%rdi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x34, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x24a0, %eax           # imm = 0x24A0
               	movl	$0xa, %esi
               	xorl	%ecx, %ecx
               	imulq	$0x1999999a, %rax, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	movq	%rdx, %rdi
               	imulq	%rsi, %rdi
               	subq	%rdi, %rax
               	addq	%rax, %rcx
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	$0x19, %ecx
               	je	<addr>
               	movl	$0x35, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	addq	$0xa, %rax
               	popq	%rbx
               	leave
               	retq

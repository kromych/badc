
call_conv_of_result_types.x64:	file format elf64-x86-64

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

<msf>:
               	leaq	(%rcx,%rcx,4), %rax
               	addq	%rdx, %rax
               	retq

<svf>:
               	leaq	(%rdi,%rdi,2), %rax
               	subq	%rsi, %rax
               	retq

<lookup>:
               	cmpq	$0x7, %rdi
               	jne	<addr>
               	leaq	-<rip>, %rax       # <addr>
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<lookup2>:
               	cmpq	$0x8, %rdi
               	jne	<addr>
               	leaq	-<rip>, %rax       # <addr>
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<block_prototypes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movl	$0x7, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %r13
               	movl	$0x8, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %edi
               	callq	<addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$-0x1, %rax
               	jmp	<addr>
               	movq	$-0x1, %rax
               	jmp	<addr>

<block_pointers>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movl	$0x7, %edi
               	callq	<addr>
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0x2710, %rax, %r13     # imm = 0x2710
               	movl	$0x8, %edi
               	callq	<addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %r13
               	movl	$0x7, %edi
               	callq	<addr>
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	addq	%r13, %rax
               	subq	$0x17, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<nested_declarator>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movl	$0x7, %edi
               	callq	<addr>
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %r13
               	movl	$0x8, %edi
               	callq	<addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<file_scope>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movl	$0x7, %edi
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0x2710, %rax, %r13     # imm = 0x2710
               	movl	$0x7, %edi
               	callq	<addr>
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %r13
               	movl	$0x8, %edi
               	callq	<addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<through_parameter>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rax
               	movq	%rsi, %rbx
               	movl	$0x7, %edi
               	callq	*%rax
               	movl	$0x3, %edx
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	callq	*%rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x905, %rax            # imm = 0x905
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x385f4, %rax          # imm = 0x385F4
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x905, %rax            # imm = 0x905
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x38b75, %rax          # imm = 0x38B75
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi        # <addr>
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)

<get_ms>:
               	xorl	%eax, %eax
               	cmpq	$0x7, %rdi
               	jne	<addr>
               	leaq	-<rip>, %rax      # <addr>
               	retq

<get_sv>:
               	xorl	%eax, %eax
               	cmpq	$0x8, %rdi
               	jne	<addr>
               	leaq	-<rip>, %rax      # <addr>
               	retq

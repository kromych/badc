
call_conv_block_scope.x64:	file format elf64-x86-64

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

<plainf>:
               	shlq	%rdi
               	leaq	(%rdi,%rsi), %rax
               	retq

<via_typedef>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %r13
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %r14
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%r13
               	addq	%r14, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq

<via_declarator>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %r13
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %r14
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%r13
               	addq	%r14, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq

<via_static>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %rcx
               	movq	%rsi, %rdx
               	leaq	<rip>, %rsi      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	subq	$0x20, %rsp
               	callq	*%rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<via_list>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	popq	%rbp
               	retq

<after_declarator>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rsi
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r13
               	movq	(%rax), %r14
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rsi
               	addq	$0x20, %rsp
               	imulq	$0x2710, %rax, %r15     # imm = 0x2710
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%r13
               	imulq	$0x64, %rax, %rax
               	leaq	(%r15,%rax), %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%r14
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<shadowed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	imulq	$0x64, %rax, %r14
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%r13
               	leaq	(%r14,%rax), %r13
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0x2710, %rax, %rax     # imm = 0x2710
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq

<leading_and_trailing>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<with_extern>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	movl	$0x5, %eax
               	subq	$0x30, %rsp
               	movq	%rax, 0x20(%rsp)
               	callq	<addr>
               	addq	$0x30, %rsp
               	imulq	$0x64, %rax, %rbx
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	callq	<addr>
               	addq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq

<through_function_typedef>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<after_asm_label>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<over_a_list>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
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
               	cmpq	$0x905, %rax            # imm = 0x905
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x386c7, %rax          # imm = 0x386C7
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x386c5, %rax          # imm = 0x386C5
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0xc35, %rax            # imm = 0xC35
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x15b3, %rax           # imm = 0x15B3
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0xc35, %rax            # imm = 0xC35
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0xc35, %rax            # imm = 0xC35
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x915, %rax            # imm = 0x915
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%cl, -0x73(%rax)

<ms_ext>:
               	leaq	(%rdx,%rcx,8), %rax
               	subq	%rcx, %rax
               	retq

<sv_ext>:
               	leaq	(,%rdi,8), %rax
               	subq	%rdi, %rax
               	subq	%rsi, %rax
               	retq

<ms5>:
               	movq	%rcx, %rax
               	leaq	(%rax,%rdx,2), %rax
               	leaq	(%r8,%r8,2), %r10
               	addq	%r10, %rax
               	leaq	(%rax,%r9,4), %rax
               	movq	0x28(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	addq	%r10, %rax
               	retq

<sv5>:
               	movq	%rdi, %rax
               	leaq	(%rax,%rsi,2), %rax
               	leaq	(%rdx,%rdx,2), %r10
               	addq	%r10, %rax
               	leaq	(%rax,%rcx,4), %rax
               	leaq	(%r8,%r8,4), %r10
               	addq	%r10, %rax
               	retq

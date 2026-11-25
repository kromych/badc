
call_conv_block_scope.x64:	file format elf64-x86-64

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
               	pushq	%rax
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	imulq	$0x64, %rax, %r14
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%r13
               	addq	%r14, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r11
               	retq

<via_declarator>:
               	pushq	%rax
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	imulq	$0x64, %rax, %r14
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%r13
               	addq	%r14, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r11
               	retq

<via_static>:
               	pushq	%rax
               	subq	$0x20, %rsp
               	movq	%rdi, %rcx
               	movq	%rsi, %rdx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	callq	*%rax
               	addq	$0x20, %rsp
               	popq	%r11
               	retq

<via_list>:
               	pushq	%rax
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	popq	%r11
               	retq

<after_declarator>:
               	subq	$0x10, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	<rip>, %r14 # <addr>
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
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
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x10, %rsp
               	retq

<shadowed>:
               	pushq	%rax
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	imulq	$0x64, %rax, %r14
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%r13
               	leaq	(%r14,%rax), %r13
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	imulq	$0x2710, %rax, %rax     # imm = 0x2710
               	addq	%r13, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r11
               	retq

<leading_and_trailing>:
               	subq	$0x10, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	imulq	$0x64, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x10, %rsp
               	retq

<with_extern>:
               	subq	$0x10, %rsp
               	pushq	%rbx
               	subq	$0x30, %rsp
               	movq	$0x5, 0x20(%rsp)
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	callq	<addr>
               	imulq	$0x64, %rax, %rbx
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	callq	<addr>
               	addq	%rbx, %rax
               	addq	$0x30, %rsp
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq

<through_function_typedef>:
               	subq	$0x10, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	imulq	$0x64, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x10, %rsp
               	retq

<after_asm_label>:
               	subq	$0x10, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	imulq	$0x64, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x10, %rsp
               	retq

<over_a_list>:
               	subq	$0x10, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	imulq	$0x64, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x10, %rsp
               	retq

<main>:
               	pushq	%rax
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x905, %rax            # imm = 0x905
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x905, %rax            # imm = 0x905
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x386c7, %rax          # imm = 0x386C7
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x386c5, %rax          # imm = 0x386C5
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0xc35, %rax            # imm = 0xC35
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpq	$0x15b3, %rax           # imm = 0x15B3
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0xc35, %rax            # imm = 0xC35
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0xc35, %rax            # imm = 0xC35
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x915, %rax            # imm = 0x915
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
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

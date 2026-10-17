
call_conv_typedef_scopes.x64:	file format elf64-x86-64

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

<depths>:
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
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%rax, %r13
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	addq	%r13, %rax
               	cmpq	$0x2e, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<shadow_global>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x2710, %rax, %r13     # imm = 0x2710
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<after_shadow>:
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
               	imulq	$0x2710, %rax, %r13     # imm = 0x2710
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %r13
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<param_shadow>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	movq	%rdx, %rsi
               	callq	*%rax
               	popq	%rbp
               	retq

<extern_past_local>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x2710, %rax, %rax     # imm = 0x2710
               	addq	%rax, %r13
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0xf4240, %rax, %rax    # imm = 0xF4240
               	addq	%rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x5f5e100, %rax, %rax  # imm = 0x5F5E100
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<typedef_over_object>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %rcx
               	movq	%rsi, %rdx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	callq	*%rax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rax
               	popq	%rbp
               	retq

<typedef_rebind>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	imulq	$0x64, %rax, %r13
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<list_mix>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x8(%rbp)
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	imulq	$0x2710, %rax, %r13     # imm = 0x2710
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %r13
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x16897, %rax          # imm = 0x16897
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x385ff, %rax          # imm = 0x385FF
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x37059375, %rax       # imm = 0x37059375
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0xdf, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x8af, %rax            # imm = 0x8AF
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x386c5, %rax          # imm = 0x386C5
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq


call_conv_typedef_scopes.x64:	file format elf64-x86-64

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

<depths>:
               	subq	$0x18, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	movq	%rax, 0x38(%rsp)
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x38(%rsp), %rax
               	addq	%r10, %rax
               	movl	$0x7, %ecx
               	xorl	%edx, %edx
               	cmpq	$0x2e, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq

<shadow_global>:
               	subq	$0x10, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x2710, %rax, %r13     # imm = 0x2710
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %r13
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

<after_shadow>:
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
               	imulq	$0x2710, %rax, %r13     # imm = 0x2710
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %r13
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	addq	%r13, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x10, %rsp
               	retq

<param_shadow>:
               	pushq	%rax
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	movq	%rdx, %rsi
               	callq	*%rax
               	popq	%r11
               	retq

<extern_past_local>:
               	subq	$0x10, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x2710, %rax, %rax     # imm = 0x2710
               	addq	%rax, %r13
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	imulq	$0xf4240, %rax, %rax    # imm = 0xF4240
               	addq	%rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x5f5e100, %rax, %rax  # imm = 0x5F5E100
               	addq	%r13, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x10, %rsp
               	retq

<typedef_over_object>:
               	pushq	%rax
               	subq	$0x20, %rsp
               	movq	%rdi, %rcx
               	movq	%rsi, %rdx
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	addq	$0xc8, %rax
               	addq	$0x20, %rsp
               	popq	%r11
               	retq

<typedef_rebind>:
               	subq	$0x10, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
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
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	%r13, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x10, %rsp
               	retq

<list_mix>:
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
               	testl	%eax, %eax
               	je	<addr>
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x16897, %rax          # imm = 0x16897
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x385ff, %rax          # imm = 0x385FF
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%r11
               	retq
               	leaq	-<rip>, %rdi # <addr>
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x37059375, %rax       # imm = 0x37059375
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0xdf, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x8af, %rax            # imm = 0x8AF
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x386c5, %rax          # imm = 0x386C5
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq

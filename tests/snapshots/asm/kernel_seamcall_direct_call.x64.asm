
kernel_seamcall_direct_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<tdh_vp_rd>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdx, %r14
               	leaq	-0x20(%rbp), %r12
               	xorq	%rax, %rax
               	movq	%rax, (%r12)
               	movq	%rax, 0x8(%r12)
               	movq	%rax, 0x10(%r12)
               	movq	%rax, 0x18(%r12)
               	movq	%rdi, (%r12)
               	movq	%rsi, 0x8(%r12)
               	movl	$0x1a, %r13d
               	movl	$0xa, %ebx
               	movq	$0x0, %rax
		R_X86_64_32S	preempt_count
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	addl	$0x1, (%rax)
               	movq	-0x40(%rbp), %rax
               	movq	$0x0, %rax
		R_X86_64_32S	cache_state_incoherent
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	movb	$0x1, (%rax)
               	movq	-0x40(%rbp), %rax
               	movq	%r13, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
		R_X86_64_PLT32	__seamcall_ret-0x4
               	movq	%rax, %rcx
               	movq	$0x0, %rax
		R_X86_64_32S	preempt_count
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	subl	$0x1, (%rax)
               	movq	-0x40(%rbp), %rax
               	movq	%rsp, %rax
               	movq	%rax, -0x40(%rbp)
               	callq	<addr>
		R_X86_64_PLT32	preempt_schedule_thunk-0x4
               	movabsq	$-0x7ffffdfd00000000, %r11 # imm = 0x8000020300000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	decq	%rbx
               	movslq	%ebx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	0x10(%rax), %rax
               	movq	%rax, (%r14)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	%rcx, %rax
               	leave
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

<tdh_vp_enter>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsi)
               	xorq	%rdi, %rdi
               	movq	$0x0, %rax
		R_X86_64_32S	cache_state_incoherent
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movb	$0x1, (%rax)
               	movq	-0x10(%rbp), %rax
               	callq	<addr>
		R_X86_64_PLT32	__seamcall_saved_ret-0x4
               	leave
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

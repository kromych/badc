
kernel_seamcall_direct_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<tdh_vp_rd>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdx, %r14
               	leaq	-0x20(%rbp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movups	%xmm14, 0x10(%r12)
               	movq	%rdi, (%r12)
               	movq	%rsi, 0x8(%r12)
               	movl	$0x1a, %r13d
               	movl	$0xa, %ebx
               	addl	$0x1, (%rip)            # <addr>
		R_X86_64_PC32	preempt_count-0x5
               	movb	$0x1, (%rip)            # <addr>
		R_X86_64_PC32	cache_state_incoherent-0x5
               	movq	%r13, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
		R_X86_64_PLT32	__seamcall_ret-0x4
               	movq	%rax, %rcx
               	subl	$0x1, (%rip)            # <addr>
		R_X86_64_PC32	preempt_count-0x5
               	movq	%rsp, %rax
               	callq	<addr>
		R_X86_64_PLT32	preempt_schedule_thunk-0x4
               	movabsq	$-0x7ffffdfd00000000, %r11 # imm = 0x8000020300000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	decq	%rbx
               	movslq	%ebx, %rax
               	testq	%rax, %rax
               	jne	<addr>
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
               	movq	%rdi, (%rsi)
               	xorq	%rdi, %rdi
               	movb	$0x1, (%rip)            # <addr>
		R_X86_64_PC32	cache_state_incoherent-0x5
               	callq	<addr>
		R_X86_64_PLT32	__seamcall_saved_ret-0x4
               	popq	%rbp
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4


kernel_seamcall_direct_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<tdh_vp_rd>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdx, %r14
               	leaq	-0x20(%rbp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movups	%xmm14, 0x10(%r12)
               	movq	%rdi, (%r12)
               	movq	%rsi, 0x8(%r12)
               	movl	$0x1a, %r13d
               	movl	$0xa, %ebx
               	jmp	<addr>
               	decq	%rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	addl	$0x1, (%rip)            # <addr>
		R_X86_64_PC32	preempt_count-0x5
               	movb	$0x1, (%rip)            # <addr>
		R_X86_64_PC32	cache_state_incoherent-0x5
               	movq	%r13, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
		R_X86_64_PLT32	__seamcall_ret-0x4
               	subl	$0x1, (%rip)            # <addr>
		R_X86_64_PC32	preempt_count-0x5
               	movq	%rsp, %rcx
               	callq	<addr>
		R_X86_64_PLT32	preempt_schedule_thunk-0x4
               	movabsq	$-0x7ffffdfd00000000, %r11 # imm = 0x8000020300000000
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	je	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	movq	%rcx, (%r14)
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

<tdh_vp_enter>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, (%rsi)
               	xorl	%edi, %edi
               	movb	$0x1, (%rip)            # <addr>
		R_X86_64_PC32	cache_state_incoherent-0x5
               	callq	<addr>
		R_X86_64_PLT32	__seamcall_saved_ret-0x4
               	popq	%rbp
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
